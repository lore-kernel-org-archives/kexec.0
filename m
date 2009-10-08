Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f188.google.com ([209.85.211.188])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Mvqsa-0007EA-TM
	for kexec@lists.infradead.org; Thu, 08 Oct 2009 11:09:57 +0000
Received: by ywh26 with SMTP id 26so5193434ywh.12
	for <kexec@lists.infradead.org>; Thu, 08 Oct 2009 04:09:50 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 8 Oct 2009 19:09:50 +0800
Message-ID: <e997b7420910080409g6efe1ea6p49cca8b3cba010be@mail.gmail.com>
Subject: What is purgatory?
From: "wilbur.chan" <wilbur512@gmail.com>
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
To: kexec@lists.infradead.org

mips32 , kexec



mips-setup-simpile.S:


In purgatory code, kexec setuped  boot_note structure for kernel to
reboot.It accomplished

this by copying the "kexec" string address to the end of boot_note
struct ,  followed by the commandline

pointer stored behind,  and passed in the address of command_line to
second kernel by setting

the value of a1 register to the address of "kexec" string.



What puzzled me is that,in purgatory code,

why      "lw      t2,12(t4)"     could put t2 with the value of  size
of boot_notes?

As I know , t4 is the entry address of kernel , why this code above
could get the size of

boot_notes? how?

Does this mean every kernel of elf format has a head structure of boot_note?



Thank you

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
