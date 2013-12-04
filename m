Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VoG6j-00031Q-0D
 for kexec@lists.infradead.org; Wed, 04 Dec 2013 17:19:29 +0000
Date: Wed, 4 Dec 2013 12:19:04 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 4/6] kexec: A new system call, kexec_file_load, for in
 kernel kexec
Message-ID: <20131204171904.GA19087@redhat.com>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <1384969851-7251-5-git-send-email-vgoyal@redhat.com>
 <20131129031048.GE4318@dhcp-16-252.nay.redhat.com>
 <20131202154437.GF18642@redhat.com>
 <20131204013529.GA3298@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131204013529.GA3298@localhost.localdomain>
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

On Wed, Dec 04, 2013 at 09:35:29AM +0800, Baoquan He wrote:
> On 12/02/13 at 10:44am, Vivek Goyal wrote:
> > On Fri, Nov 29, 2013 at 11:10:48AM +0800, Baoquan He wrote:
> > 
> > [..]
> > > > +void *arch_kexec_kernel_image_load(struct kimage *image, char *kernel,
> > > > +			unsigned long kernel_len, char *initrd,
> > > > +			unsigned long initrd_len, char *cmdline,
> > > > +			unsigned long cmdline_len)
> > > > +{
> > > > +	int idx = image->file_handler_idx;
> > > > +
> > > > +	if (idx < 0)
> > > > +		return ERR_PTR(-ENOEXEC);
> > > > +
> > > > +	return kexec_file_type[idx].load(image, kernel, kernel_len, initrd,
> > > > +					initrd_len, cmdline, cmdline_len);
> > > > +}
> > > > +
> > > > +int arch_image_file_post_load_cleanup(struct kimage *image)
> > > > +{
> > > 
> > > Hi Vivek,
> > > 
> > > This function is defined as one of arch specific fucntion set, why don't
> > > we name it in a unified prefix as others.
> > 
> > I am using "arch_" prefix. What else to use?
> 
> I mean in this function series, other functions have name like
> arch_kexec_kernel_image_xxx, why this function is lonely, and is named
> as arch_kimage_xxx. And here what does the 'k' mean in "kimage", kexec
> image or kernel image, I am confused.

kimage is name is structure which is containing all the data relevant
to loading of file. 

I guess I can use arch_kimage_file_post_load_cleanup().

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
