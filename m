Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XKXrC-0003M8-IY
 for kexec@lists.infradead.org; Thu, 21 Aug 2014 19:17:11 +0000
Date: Thu, 21 Aug 2014 15:16:46 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kexec fails to boot kernels where CONFIG_RANDOMIZE_BASE=y is set
Message-ID: <20140821191646.GF21891@redhat.com>
References: <53F11882.3060803@whissi.de> <20140818145718.GD4745@redhat.com>
 <20140819090724.GB21724@dhcp-17-37.nay.redhat.com>
 <20140820143315.GC16303@redhat.com>
 <CAGXu5jLxEoKEy0nw8qj0MW0f2Vpog-DtDi7OwnUrkh7jGSkdWw@mail.gmail.com>
 <20140821181000.GB21891@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140821181000.GB21891@redhat.com>
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
To: Kees Cook <keescook@chromium.org>
Cc: "Thomas D." <whissi@whissi.de>, Kexec Mailing List <kexec@lists.infradead.org>, WANG Chao <chaowang@redhat.com>

On Thu, Aug 21, 2014 at 02:10:00PM -0400, Vivek Goyal wrote:

[..]
> If kernel always moves itself to higher addresses then one solution could
> be that load everything else below kernel and load kernel at higher
> addresses. But old kexec system call will not be able to cope with it as
> user space determines the load location of kernel and other segments while
> running kernel decides location of pages for page table and kernel has
> no idea where user space has loaded new kernel. New system call still
> might be able to handle it.

So I am reading kaslr code a bit. First of all we are moving kernel in
physical address space. That would substantiate the theory that kernel
movement stepped onto something.

Basically we seem to be just going through all the e820 entries, putting
them one slots[] array and choosing one entry randomly.

That means kernel could move up or down. So the notion of loading
everything else below kernel will not work.

Now this makes me wonder that how does this whole thing work with grub.
IOW, how would one make sure that kernel does not stomp initramfs.

I guess only protection is BASE_MAX_OFFSET and making sure initramfs is
loaded higher than that.

If that's the case, then I think minimum and maximum range of physical
memory where kernel can move should be exported through bzImage header
and kexec-tools should make sure that anything else is outside of that
range so that new kernel will not stomp over it.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
