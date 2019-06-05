Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hYKDk-0007ct-Qx
 for kexec@lists.infradead.org; Wed, 05 Jun 2019 00:56:06 +0000
Date: Wed, 5 Jun 2019 08:56:00 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: The current SME implementation fails kexec/kdump kernel booting.
Message-ID: <20190605005600.GF26891@MiWiFi-R3L-srv>
References: <20190604134952.GC26891@MiWiFi-R3L-srv>
 <508c2853-dc4f-70a6-6fa8-97c950dc31c6@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <508c2853-dc4f-70a6-6fa8-97c950dc31c6@amd.com>
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
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 06/04/19 at 03:56pm, Lendacky, Thomas wrote:
> On 6/4/19 8:49 AM, Baoquan He wrote:
> > Hi Tom,
> > 
> > Lianbo reported kdump kernel can't boot well with 'nokaslr' added, and
> > have to enable KASLR in kdump kernel to make it boot successfully. This
> > blocked his work on enabling sme for kexec/kdump. And on some machines
> > SME kernel can't boot in 1st kernel.
> > 
> > I checked code of SME implementation, and found out the root cause. The
> > above failures are caused by SME code, sme_encrypt_kernel(). In
> > sme_encrypt_kernel(), you get a 2M of encryption work area as intermediate
> > buffer to encrypt kernel in-place. And the work area is just after _end of
> > kernel.
> 
> I remember worrying about something like this back when I was testing the
> kexec support. I had come up with a patch to address it, but never got the
> time to test and submit it.  I've included it here if you'd like to test
> it (I haven't done run this patch in quite some time). If it works, we can
> think about submitting it.

Thanks for your quick response and making this patch, Tom.

Tested on a speedway machine, it entered into kernel, but failed in
below stage. Tested two times, always happened.


[    4.978521] Freeing unused decrypted memory: 2040K
[    4.983800] Freeing unused kernel image memory: 2344K
[    4.988943] Write protecting the kernel read-only data: 18432k
[    4.995306] Freeing unused kernel image memory: 2012K
[    5.000488] Freeing unused kernel image memory: 256K
[    5.005540] Run /init as init process
[    5.009443] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
[    5.017230] CPU: 0 PID: 1 Comm: init Not tainted 5.2.0-rc2+ #38
[    5.023251] Hardware name: AMD Corporation Speedway/Speedway, BIOS RSW1004B 10/18/2017
[    5.031299] Call Trace:
[    5.033793]  dump_stack+0x46/0x60
[    5.037169]  panic+0xfb/0x2cb
[    5.040191]  do_exit.cold.21+0x59/0x81
[    5.044004]  do_group_exit+0x3a/0xa0
[    5.047640]  __x64_sys_exit_group+0x14/0x20
[    5.051899]  do_syscall_64+0x55/0x1c0
[    5.055627]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    5.060764] RIP: 0033:0x7fa1b1fc9e2e
[    5.064404] Code: Bad RIP value.
[    5.067687] RSP: 002b:00007fffc5abb778 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
[    5.075296] RAX: ffffffffffffffda RBX: 00007fa1b1fd2528 RCX: 00007fa1b1fc9e2e
[    5.082625] RDX: 000000000000007f RSI: 000000000000003c RDI: 000000000000007f
[    5.089879] RBP: 00007fa1b21d8d00 R08: 00000000000000e7 R09: 00007fffc5abb688
[    5.097134] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
[    5.104386] R13: 0000000000000001 R14: 00007fa1b21d8d40 R15: 00007fa1b21d8d30
[    5.111645] Kernel Offset: disabled
[    5.423002] Rebooting in 10 seconds..
[   15.429641] ACPI MEMORY or I/O RESET_REG.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
