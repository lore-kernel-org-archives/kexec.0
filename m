Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 22 Jun 2016 01:51:07 -0700
From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] arm: fix kernel image size
Message-ID: <20160622085105.GE22406@atomide.com>
References: <E1bDzh4-0006a4-7p@e0050434b2927.dyn.armlinux.org.uk>
 <20160621074319.GH22406@atomide.com>
 <20160621094737.GA5783@n2100.arm.linux.org.uk>
 <20160621103810.GI22406@atomide.com>
 <20160621105720.GK22406@atomide.com>
 <20160621154407.GB5783@n2100.arm.linux.org.uk>
 <20160621165523.GY22406@atomide.com>
 <20160621215141.GC5783@n2100.arm.linux.org.uk>
 <20160622073614.GZ22406@atomide.com>
 <20160622082958.GD5783@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160622082958.GD5783@n2100.arm.linux.org.uk>
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
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Pratyush Anand <panand@redhat.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, Kees Cook <keescook@google.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [160622 01:32]:
> When CONFIG_DEBUG_RODATA is enabled, we align the text, read-only data,
> data, and so on to 1MB boundaries so that we can change the permissions
> of the sections to enforce the properties of the various ELF segments.
> This padding massively inflates the size of the run-time kernel image,
> and can result in megabytes of wastage (if we're as little as one byte
> into 1MB, we have to round up to the next megabyte.)

Yes understood, and looks like we cannot make any assumptions about
what the alignment might be.

> The padding, being a string of zeros, is very compressable, and this
> increases the compression ratio.
> 
> The BSS is not included in the compressed image, but needs to be taken
> account of when avoiding overwriting the DTB.
> 
> > How about we check the size of RAM available, and if there is plenty
> > of RAM we use a safe compression ratio of 8. If RAM is a problem,
> > we could make the compression ratio smaller and warn about it. And
> > we could also allow passing the compression ratio to kexec as an
> > option.
> 
> You do know that you can already pass the "size" of the kernel to be
> reserved to kexec.  --image-size.  It's not documented in --help, but
> it is there (which is another annoying thing about ARM kexec...)

Oh ok that's nice.

Regards,

Tony

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
