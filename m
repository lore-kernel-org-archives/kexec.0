Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yx0-f175.google.com ([209.85.210.175])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MwzTW-0005wE-5w
	for kexec@lists.infradead.org; Sun, 11 Oct 2009 14:32:47 +0000
Received: by yxe5 with SMTP id 5so850839yxe.24
	for <kexec@lists.infradead.org>; Sun, 11 Oct 2009 07:32:39 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 11 Oct 2009 22:32:39 +0800
Message-ID: <e997b7420910110732r36306a0flceeb03f8e059a95a@mail.gmail.com>
Subject: mips32 kexec failed, bug?
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

mips32 board:


I used kexec to reboot a new kernel, but I found that , the second
kernel stopped when calling 'prom_getenv("memsize") '  in booting.


That is , kernel: setup_arch-->prom_init-->'prom_getenv("memsize")'  failed


So I checked the code in kexec-tool , and I found that ,in
mips-simple-setup.S,  register a2 was set to 0, which was passed to
the second kernel as envirment variable address.


I guess here a2 should not be set to 0 , is it a BUG in kexec-tool ,
when dealing with mips?


ps: I don't have mail address of the authors who wrote mips support
for kexec ,  Francesco Chiechi, Alessandro Rubini , Tvblob s.r.l.

So I wrote directly to this maillist to search for help.

Thank you

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
