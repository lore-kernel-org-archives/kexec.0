Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l29or-0000ou-88
 for kexec@lists.infradead.org; Wed, 20 Jan 2021 09:30:30 +0000
Date: Wed, 20 Jan 2021 17:30:15 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [bug report] PM / reboot: Eliminate race between reboot and
 suspend
Message-ID: <20210120093015.GE20161@MiWiFi-R3L-srv>
References: <20201118185917.GA433776@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201118185917.GA433776@mwanda>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: dyoung@redhat.com, kexec@lists.infradead.org, kernelfans@gmail.com, linux-pm@vger.kernel.org

Hi,

On 11/18/20 at 09:59pm, Dan Carpenter wrote:
> Hello Pingfan Liu,
> 
> The patch 55f2503c3b69: "PM / reboot: Eliminate race between reboot
> and suspend" from Jul 31, 2018, leads to the following static checker
> warning:
> 
> 	kernel/power/main.c:27 lock_system_sleep()
> 	warn: called with lock held.  '&system_transition_mutex'

This is a good finding. I think we can simply remove the lock/unlock
pair of system_transition_mutex in kernel_kexec() function. The dead
lock should be easily triggered, but it hasn't caused any failure report
because the feature 'kexec jump' is almost not used by anyone as far as
I know. We may need to find out who is using it and where it's used
through an inquiry. Before that, we can just remove the lock operation
inside CONFIG_KEXEC_JUMP ifdeffery scope. Thanks. 


diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 80905e5aa8ae..a0b6780740c8 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1134,7 +1134,6 @@ int kernel_kexec(void)
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
-		lock_system_sleep();
 		pm_prepare_console();
 		error = freeze_processes();
 		if (error) {
@@ -1197,7 +1196,6 @@ int kernel_kexec(void)
 		thaw_processes();
  Restore_console:
 		pm_restore_console();
-		unlock_system_sleep();
 	}
 #endif
 

> 
> kernel/reboot.c
>    345  
>    346          mutex_lock(&system_transition_mutex);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> The patch changed the code to take this lock.
> 
>    347          switch (cmd) {
>    348          case LINUX_REBOOT_CMD_RESTART:
>    349                  kernel_restart(NULL);
>    350                  break;
>    351  
>    352          case LINUX_REBOOT_CMD_CAD_ON:
>    353                  C_A_D = 1;
>    354                  break;
>    355  
>    356          case LINUX_REBOOT_CMD_CAD_OFF:
>    357                  C_A_D = 0;
>    358                  break;
>    359  
>    360          case LINUX_REBOOT_CMD_HALT:
>    361                  kernel_halt();
>    362                  do_exit(0);
>    363                  panic("cannot halt");
>    364  
>    365          case LINUX_REBOOT_CMD_POWER_OFF:
>    366                  kernel_power_off();
>    367                  do_exit(0);
>    368                  break;
>    369  
>    370          case LINUX_REBOOT_CMD_RESTART2:
>    371                  ret = strncpy_from_user(&buffer[0], arg, sizeof(buffer) - 1);
>    372                  if (ret < 0) {
>    373                          ret = -EFAULT;
>    374                          break;
>    375                  }
>    376                  buffer[sizeof(buffer) - 1] = '\0';
>    377  
>    378                  kernel_restart(buffer);
>    379                  break;
>    380  
>    381  #ifdef CONFIG_KEXEC_CORE
>    382          case LINUX_REBOOT_CMD_KEXEC:
>    383                  ret = kernel_kexec();
>                         ^^^^^^^^^^^^^^^^^^^^
> Called with lock held.
> 
>    384                  break;
>    385  #endif
> 
> But kernel_kexec() also tries to take the &system_transition_mutex so
> it will dead lock.
> 
> kernel/kexec_core.c
>   1125  int kernel_kexec(void)
>   1126  {
>   1127          int error = 0;
>   1128  
>   1129          if (!mutex_trylock(&kexec_mutex))
>   1130                  return -EBUSY;
>   1131          if (!kexec_image) {
>   1132                  error = -EINVAL;
>   1133                  goto Unlock;
>   1134          }
>   1135  
>   1136  #ifdef CONFIG_KEXEC_JUMP
>   1137          if (kexec_image->preserve_context) {
>   1138                  lock_system_sleep();
>                         ^^^^^^^^^^^^^^^^^^^
> Here.
> 
>   1139                  pm_prepare_console();
>   1140                  error = freeze_processes();
>   1141                  if (error) {
>   1142                          error = -EBUSY;
>   1143                          goto Restore_console;
>   1144                  }
>   1145                  suspend_console();
>   1146                  error = dpm_suspend_start(PMSG_FREEZE);
>   1147                  if (error)
>   1148                          goto Resume_console;
>   1149                  /* At this point, dpm_suspend_start() has been called,
>   1150                   * but *not* dpm_suspend_end(). We *must* call
>   1151                   * dpm_suspend_end() now.  Otherwise, drivers for
>   1152                   * some devices (e.g. interrupt controllers) become
>   1153                   * desynchronized with the actual state of the
>   1154                   * hardware at resume time, and evil weirdness ensues.
>   1155                   */
>   1156                  error = dpm_suspend_end(PMSG_FREEZE);
>   1157                  if (error)
>   1158                          goto Resume_devices;
>   1159                  error = suspend_disable_secondary_cpus();
>   1160                  if (error)
> 
> regards,
> dan carpenter
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
