Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from web26607.mail.ukl.yahoo.com ([217.146.176.57])
	by bombadil.infradead.org with smtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KVR2h-0002Po-Am
	for kexec@lists.infradead.org; Tue, 19 Aug 2008 13:14:35 +0000
Date: Tue, 19 Aug 2008 13:14:34 +0000 (GMT)
From: ayoub zaki <ayoub_zaki@yahoo.fr>
Subject: kexec on ppc
MIME-Version: 1.0
Message-ID: <468456.11793.qm@web26607.mail.ukl.yahoo.com>
Reply-To: ayoub_zaki@yahoo.fr
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hello all,

I'm new to kexec and I'd like to use it with PPC_85xx:
To get kexec enabled for my processor I used the following patch http://patchwork.ozlabs.org/linuxppc/patch?id=14899

I compiled kexec for my target and now I'm getting in trouble :

-sh-2.05b# ./kexec -l /mnt/nfs/uImage
Cannot determine the file type of /mnt/nfs/uImage

-sh-2.05b# ./kexec -l /boot/vmlinux
Invalid memory segment (nil) - 0x48efff

Which kind of kernel image should I use ? 

Thanks,




      _____________________________________________________________________________ 
Envoyez avec Yahoo! Mail. Une boite mail plus intelligente http://mail.yahoo.fr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
