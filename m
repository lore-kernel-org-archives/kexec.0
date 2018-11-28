Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 28 Nov 2018 19:38:19 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2] x86_64, vmcoreinfo: Append 'page_offset_base' to
 vmcoreinfo
Message-ID: <20181128113819.GA19079@dhcp-128-65.nay.redhat.com>
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
 <20181121113944.GD27797@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181121113944.GD27797@zn.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Kees Cook <keescook@chromium.org>, Baoquan He <bhe@redhat.com>, Bhupesh Sharma <bhsharma@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Dave Anderson <anderson@redhat.com>, James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>, bhupesh.linux@gmail.com, Omar Sandoval <osandov@fb.com>, linux-arm-kernel@lists.infradead.org

> > now possible to use the vmcoreinfo present inside kcore as the standard
> > ABI which can be used by the user-space utilities for reading
> > the machine specific information (and hence for debugging a
> > live kernel).
> > 
> > User-space utilities like makedumpfile, kexec-tools and crash
> > are either already using this ABI or are discussing patches
> > which look to add the same feature. This helps in simplifying the
> > overall code and also in reducing code-rewrite across the
> > user-space utilities for getting values of these kernel
> > symbols/variables.
> 
> > Accordingly this patch allows appending 'page_offset_base' for
> > x86_64 platforms to vmcoreinfo, so that user-space tools can use the
> > same as a standard interface to determine the start of direct mapping
> > of all physical memory.
> > 

[snip]

> All above are only nitpicks though.
> 
> My opinion is this: people are exporting all kinds of kernel-internal
> stuff in vmcoreinfo and frankly, I'm not crazy about this idea.
> 
> And AFAICT, this thing basically bypasses KASLR completely but you need
> root for it so it probably doesn't really matter.
> 
> Now, on another thread we agreed more or less that what gets exported in
> vmcoreinfo is so tightly coupled to the running kernel so that it is not
> even considered an ABI. I guess that is debatable but whatever.

We do not regard this strictly as an ABI, but we also carefully review
every new extra exported thing and only export when we have to do so eg.
something breaks.

Seems this change only make userspace tools handling on the kaslr case
easier but since everything works without this patch I would prefer not to
do it.

> 
> So my only request right now would be to have all those things being
> exported, documented somewhere and I believe Lianbo is working on that.
> 
> But I'm sure others will have more to say about it.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
