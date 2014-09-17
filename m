Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XUFiL-0001xQ-VE
 for kexec@lists.infradead.org; Wed, 17 Sep 2014 13:56:10 +0000
Date: Wed, 17 Sep 2014 09:55:44 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <56999675.16763362.1410962144335.JavaMail.zimbra@redhat.com>
In-Reply-To: <5418F4D8.2070301@cn.fujitsu.com>
References: <mailman.12983.1410860958.22890.kexec@lists.infradead.org>
 <1344663963.15300444.1410873613602.JavaMail.zimbra@redhat.com>
 <5418F4D8.2070301@cn.fujitsu.com>
Subject: Re: [PATCH 2/2] makedumpfile: make the incomplete vmcore generated
 by ENOSPC error analyzable
MIME-Version: 1.0
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
To: Xiao Wang/Wang Xiao <wangx.fnst@cn.fujitsu.com>
Cc: kexec@lists.infradead.org



----- Original Message -----
> Hello Dave,
> 
> Thanks for your reply.
> 
> We can use two methods to indicate that the incomplete vmcore is a "fixed" one,
> 1. Use a flag in elf/kdump dumpfile(like "e_flags" in ELF header and "status"
>     in disk_dump_header) to indicate it has been "fixed". But actually the
>     kdump-compressed file needn't to use such a flag, for we just change the
>     data write order of this format.

I don't understand.

First, let's stop using the "fixed" description.  It is definitely *not* fixed, but 
rather it is still a bogus, incomplete, dumpfile, and the user should be made aware 
of that fact.  

For compressed kdumps, the disk_dump_header.status field currently uses these
three bits:

 #define DUMP_DH_COMPRESSED_ZLIB    0x1   /* page is compressed with zlib */
 #define DUMP_DH_COMPRESSED_LZO     0x2   /* page is compressed with lzo */
 #define DUMP_DH_COMPRESSED_SNAPPY  0x4   /* page is compressed with snappy */
 
Can you please simply add a DUMP_DH_COMPRESSED_INCOMPLETE flag?

With respect to ELF vmcores, the processor-specific e_flags field is unused by the
crash utility, and it appears that makedumpfile always sets it to zero.  But
I'm not sure what the kernel does when /proc/vmcore is created?  Could there
be e_flags bits set there that a direct-copy of /proc/vmcore might contain?
That's why I suggested a unique ELF note.  

Then, if the flag is set, the crash utility can display "[INCOMPLETE]" next
to the dumpfile file name in the initial system banner and by the "sys" command.

And in the highly-likely event where the vmcore fails to initialize -- in that
case "crash -d1" can display the header contents immediately during invocation.  
That way, instead of users complaining about the crash utility, the blame can be
placed where it belongs.

> 2. We can just let makedumpfile change the "fixed" dumpfile's filename automatically.
>     Such as add a "-truncated" flag after those dumpfiles.

You probably should do that -- in *addition* to setting a flag in the header.  
Since there's no way to prevent a user from re-naming the file, without a flag,
there would be no way of confirming that it was a bogus dumpfile to begin with.

Thanks,
  Dave
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
