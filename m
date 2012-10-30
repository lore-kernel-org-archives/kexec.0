Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TT3E8-0005ra-3Y
 for kexec@lists.infradead.org; Tue, 30 Oct 2012 04:14:57 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <loom.20121030T014113-581@post.gmane.org>
Date: Mon, 29 Oct 2012 21:14:33 -0700
In-Reply-To: <loom.20121030T014113-581@post.gmane.org> (Joshua Jensen's
 message of "Tue, 30 Oct 2012 00:49:39 +0000 (UTC)")
Message-ID: <87390wfvfa.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: kexec-tools not loading iPXE zImage
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
To: Joshua Jensen <joshua@joshuajensen.org>
Cc: kexec@lists.infradead.org

Joshua Jensen <joshua@joshuajensen.org> writes:

> I'm having an issue with kexec not being able to load a freshly compiled 
> ipxe.lkrn file, even though it is a zImage:
>
>
> # file ipxe.lkrn
> ipxe.lkrn: Linux kernel x86 boot executable zImage, version \353FHdrS\007\002,RW-
> rootFS,
>
> # kexec -l ipxe.lkrn
> Cannot determine the file type of ipxe.lkrn
>
>
> Any ideas?  Is there any way to determine where the error is, with the ipxe.lkrn 
> file or kexec ?

Use the source?

My guess is that ipxe.lkrn uses a very old version of the x86 boot
protocol.

Doing what you are doing is a bit iffy if the version of ipxe you are
building depends upon BIOS calls.

It used to be possible to build a .elf version of etherboot that was
bootable via linuxbios and depended on no BIOS calls, and that should
work if the code survived the great gutting of etherboot.

Although this does seem a bit of a round about way to get something
done, loading a more limited bootloader from what is essentially a more
featureful bootloader.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
