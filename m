Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TscKm-0005ya-6c
 for kexec@lists.infradead.org; Tue, 08 Jan 2013 16:47:29 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] Only reset e820 once,
 even with multiple memmap=exactmap params
Date: Tue, 8 Jan 2013 17:47:17 +0100
References: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
 <3649945.08HKjS0y0c@hammer82.arch.suse.de>
 <CAE9FiQUueTB6gc5uMUApqeS7FtzMESLLFEt3ZuOMJgXsnjFQ0A@mail.gmail.com>
In-Reply-To: <CAE9FiQUueTB6gc5uMUApqeS7FtzMESLLFEt3ZuOMJgXsnjFQ0A@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201301081747.17853.trenn@suse.de>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Takao Indoh <indou.takao@jp.fujitsu.com>, MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>, tokunaga.keiich@jp.fujitsu.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, vgoyal@redhat.com, khalid@gonehiking.org

On Tuesday, January 08, 2013 04:04:56 AM Yinghai Lu wrote:
> On Mon, Jan 7, 2013 at 4:42 PM, Thomas Renninger <trenn@suse.de> wrote:
> > memmap=256M$3584M
> 
> may need to change to:
> 
> memmap=256M\$\$3584M
The problem is (beside the special char $) that
memmap=exactmap boot param resets all e820 maps every time the
parameter is processed.
And:
/sbin/kexec -p xy --append="..." --initrd yx
seem to magically add (append):
memmap=exactmap memmap=640K@0K memmap=392556K@115328K elfcorehdr=507884K memmap=252K#3099760K

therefore all memmap= I try to pass are voided out by:
memmap=exactmap
which is always added by kexec after my params.

I could come around with attached patch and passing:
/sbin/kexec -p xy --append='... memmap=exactmap memmap=256M$3584M' --initrd yx

Now mmconfig is working in kdump kernel.
This would mean mmconfig is broken by design in kexec?

Only way to fix this I can think of is to export
mmconfig area through /sys  (../kernel/debug/mmconfig?, possibly
already in X$Y format?) in the productive kernel and make kexec add it
like the other memmap= params automatically.

I'll attach the output in a separate mail.

   Thomas

---

x86 e820: Do not reset e820 map twice, even if memmap=exactmap is passed as boot param several times

This is needed to be able to explicitly pass (debug) e820
modifications through kexec via memmap=.
Otherwise those get voided by kexec appending memmap=exactmap always
after the user defined boot parameters.

Signed-off-by: Thomas Renninger <trenn@suse.de>

 linux-2.6_t/arch/x86/kernel/e820.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: git/linux-2.6_t/arch/x86/kernel/e820.c
===================================================================
--- git.orig/linux-2.6_t/arch/x86/kernel/e820.c
+++ git/linux-2.6_t/arch/x86/kernel/e820.c
@@ -845,7 +845,9 @@ static int __init parse_memmap_opt(char
 
 	if (!strncmp(p, "exactmap", 8)) {
 #ifdef CONFIG_CRASH_DUMP
-		/*
+		/* memmap=exactmap passed twice, do not reset tables again */
+		if (saved_max_pfn)
+			return 0;		/*
 		 * If we are doing a crash dump, we still need to know
 		 * the real mem size before original memory map is
 		 * reset.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
