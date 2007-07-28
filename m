Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IEbd0-0005Y0-2j
	for kexec@lists.infradead.org; Fri, 27 Jul 2007 22:01:59 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [BUG] i386 relocable kernel breakes /proc/kcore debugging
References: <200707280443.44048.maximlevitsky@gmail.com>
Date: Fri, 27 Jul 2007 19:58:56 -0600
In-Reply-To: <200707280443.44048.maximlevitsky@gmail.com> (Maxim Levitsky's
	message of "Sat, 28 Jul 2007 04:43:43 +0300")
Message-ID: <m1fy39thjz.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
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
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org

Maxim Levitsky <maximlevitsky@gmail.com> writes:

> Hello,
>
> Today I noticed that gdb gets confused when I try to load a vmlinux image.
> gdb 'thinks' that all kernel symbols are below 0x80000000 , while they are at 
> 0xC000....
>
> Turning CONFIG_RELOCATABLE off fixes that, so I assume that is the reason for 
> that.
>
> I am using 2.6.23-rc1, although I don't think that older versions are better.
>
> Best regards,
> 	Maxim Levitsky

Weird.

Vivek could this be related to the problem of problematic core dumps we
were seeing earlier?

Eric


> PS: 
> This is what gdb says:

>
> (gdb) disassemble sys_open
> Dump of assembler code for function sys_open:
> 0x8026fa60 <sys_open+0>:        Cannot access memory at address 0x8026fa60
>
> While real address of sys_open is:
>
> [root@MAIN linux-2.6]# nm ./.obj/vmlinux |  grep sys_open
> .........
> c016ea60 T sys_open
>
> Strange, but gdb recordnizes the above address directly:
>
> (gdb) disassemble 0xc016ea60
> Dump of assembler code for function sys_open:
> 0xc016ea60 <sys_open+0>:        sub    $0x4,%esp
> 0xc016ea63 <sys_open+3>:        mov    0x10(%esp),%eax
> ...............

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
