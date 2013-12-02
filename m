Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VnVgD-0000Qq-W1
 for kexec@lists.infradead.org; Mon, 02 Dec 2013 15:45:03 +0000
Date: Mon, 2 Dec 2013 10:44:37 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 4/6] kexec: A new system call, kexec_file_load, for in
 kernel kexec
Message-ID: <20131202154437.GF18642@redhat.com>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <1384969851-7251-5-git-send-email-vgoyal@redhat.com>
 <20131129031048.GE4318@dhcp-16-252.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131129031048.GE4318@dhcp-16-252.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: mjg59@srcf.ucam.org, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com

On Fri, Nov 29, 2013 at 11:10:48AM +0800, Baoquan He wrote:

[..]
> > +void *arch_kexec_kernel_image_load(struct kimage *image, char *kernel,
> > +			unsigned long kernel_len, char *initrd,
> > +			unsigned long initrd_len, char *cmdline,
> > +			unsigned long cmdline_len)
> > +{
> > +	int idx = image->file_handler_idx;
> > +
> > +	if (idx < 0)
> > +		return ERR_PTR(-ENOEXEC);
> > +
> > +	return kexec_file_type[idx].load(image, kernel, kernel_len, initrd,
> > +					initrd_len, cmdline, cmdline_len);
> > +}
> > +
> > +int arch_image_file_post_load_cleanup(struct kimage *image)
> > +{
> 
> Hi Vivek,
> 
> This function is defined as one of arch specific fucntion set, why don't
> we name it in a unified prefix as others.

I am using "arch_" prefix. What else to use?

> 
> And name of the default dummy function in kernel/kexec.c is not consistent
> with the arch specific one, so currently
> arch_image_file_post_load_cleanup of x86 arch is not called. Please
> consider wihch one need be changed.

Good catch Bao. I should change arch_image_file_post_load_cleanup() to
arch_kimage_file_post_load_cleanup(), otherwise it never gets called and
memory leaks.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
