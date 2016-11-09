Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c4GZm-0005jq-SI
 for kexec@lists.infradead.org; Wed, 09 Nov 2016 00:17:15 +0000
Date: Wed, 9 Nov 2016 08:16:50 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 2/2] makedumpfile: Clean up unused KERNEL_IMAGE_SIZE
Message-ID: <20161109001650.GA3598@x1>
References: <1478595319-9299-1-git-send-email-bhe@redhat.com>
 <1478595319-9299-3-git-send-email-bhe@redhat.com>
 <307037751.13707363.1478615163009.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <307037751.13707363.1478615163009.JavaMail.zimbra@redhat.com>
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
To: Dave Anderson <anderson@redhat.com>
Cc: panand@redhat.com, ats-kumagai@wm.jp.nec.com, kexec@lists.infradead.org, ebiederm@xmission.com, tglx@linutronix.de, dyoung@redhat.com

On 11/08/16 at 09:26am, Dave Anderson wrote:
> 
> 
> ----- Original Message -----
> > The old MODULES_VADDR need be decided by KERNEL_IMAGE_SIZE when kaslr
> > enabled. Now MODULES_VADDR is not needed any more since Pratyush makes
> > all VA to PA converting done by page table lookup. So remove its related
> > code.
> 
> Hi Bao,
> 
> I'm not clear on this.  The crash utility still reads/needs KERNEL_IMAGE_SIZE
> from the dumpfile's vmcoreinfo data.  Is it being written to the vmcoreinfo
> section somewhere else in the code?

Aha, seems makedumpfile will get the vmcoreinfo offset and size, then
write the whole vmcoreinfo block into dumped vmcore header. But if
specify '-g' for makedumpfile to only generate a vmcoreinfo file, it
won't contain KERNEL_IMAGE_SIZE. 

makedumpfile -g vmcoreinfo -x vmlinux

So I am not sure if you care about vmcoreinfo file, but you are right, I
should not remove the vmcoreinfo reading and writing data.

Thanks for pointing it out, will send v2 post.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
