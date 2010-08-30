Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from hera.kernel.org ([140.211.167.34])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Oq5Ex-0000T7-C1
	for kexec@lists.infradead.org; Mon, 30 Aug 2010 14:21:39 +0000
Message-ID: <4C7BBE4E.8080901@kernel.org>
Date: Mon, 30 Aug 2010 16:21:02 +0200
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
Subject: Re: kdump regression compared to v2.6.35
References: <1141332926.1524871283176937097.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1141332926.1524871283176937097.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: CAI Qian <caiqian@redhat.com>
Cc: torvalds@linux-foundation.org, linux-next@vger.kernel.org, kexec <kexec@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>

Hello,

On 08/30/2010 04:02 PM, CAI Qian wrote:
>> Hmm, odd.  So, here's the said debug patch.  It will periodically
>> check all works and report if any work is being delayed for too long.
>> If the max wait goes over 30secs, it will dump all task states and
>> disable itself.  Can you please apply the patch on top of rc2 +
>> wq#for-linus and report the output?  It should tell us who's stuck
>> where.
>
> Nothing new was printed after around 10 minutes.

Eh... that's interesting.  That means no work is stalled on
workqueues, so it at least is not a workqueue stall.  Can you please
try the following then?  Or if sysrq wasn't working because your
keyboard wasn't initialized at that point, you can setup serial
console and trigger sysrq that way.

Thanks.

diff --git a/init/main.c b/init/main.c
index 94ab488..e156b8f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -423,11 +423,19 @@ static void __init setup_command_line(char *command_line)

 static __initdata DECLARE_COMPLETION(kthreadd_done);

+static void show_state_timer_fn(unsigned long data)
+{
+	show_state();
+}
+static DEFINE_TIMER(show_state_timer, show_state_timer_fn, 0, 0);
+
 static noinline void __init_refok rest_init(void)
 	__releases(kernel_lock)
 {
 	int pid;

+	printk("XXX show_state_timer registered\n");
+	mod_timer(&show_state_timer, jiffies + 180 * HZ);
 	rcu_scheduler_starting();
 	/*
 	 * We need to spawn init first so that it obtains pid 1, however

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
