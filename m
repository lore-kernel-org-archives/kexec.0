Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wm14.inbox.com ([208.50.6.14])
	by canuck.infradead.org with smtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HyqIM-0004lF-3I
	for kexec@lists.infradead.org; Thu, 14 Jun 2007 10:27:32 -0400
Received: from inbox.com (127.0.0.1:25)
	by inbox.com with [InBox.Com SMTP Server]
	id <706140030700.WM14> for <kexec@lists.infradead.org> from
	<dseetharam@inbox.com>; Thu, 14 Jun 2007 6:27:18 AM -0800
Mime-Version: 1.0
Date: Thu, 14 Jun 2007 06:27:18 -0800
Message-ID: <C6430F72A46.000002F9dseetharam@inbox.com>
From: Dharmosoth Seetharam <dseetharam@inbox.com>
Subject: problem with elfutils-0.125 for makedumpfile
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: vgoyal@in.ibm.com

Hi, 

I tryinging to install makedumpfile utility program.
For this elfutils-0.125 should be installed on the same machine.

So, i have done the same thing.

After installing the "elfutils-0.125", I am getting the following error.

Can any one please tell me what should be the mistake i have done?


[root@tc210 makedumpfile]# make
gcc -g -O2 -Wall -D_FILE_OFFSET_BITS=64 -DVERSION='"1.1.4"' -DRELEASE_DATE='"08 June 2007"' -D__x86_64__ x86.o x86_64.o ia64.o ppc64.o -o makedumpfile makedumpfile.c -static -ldw -lelf -lz
makedumpfile.c: In function `write_kdump_pages':
makedumpfile.c:4102: warning: implicit declaration of function `compressBound'
/usr/local/bin/ld: invalid option -- Y
Try `ld --help' or `ld --usage' for more information.
collect2: ld returned 64 exit status
make: *** [makedumpfile] Error 1


This is a simple program to print Hello.
Even for this is the error is same.

[root@tc210 makedumpfile]# gcc -o test test.c
/usr/local/bin/ld: invalid option -- Y
Try `ld --help' or `ld --usage' for more information.
collect2: ld returned 64 exit status
[root@tc210 makedumpfile]#         


Thanks in Advance
Seetharam


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
