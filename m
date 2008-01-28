Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JJbEE-0000Fe-V0
	for kexec@lists.infradead.org; Mon, 28 Jan 2008 21:09:25 +0000
Date: Mon, 28 Jan 2008 16:09:17 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Kexec command line length
Message-ID: <20080128210917.GF32765@redhat.com>
References: <20080125153924.GA13287@redhat.com> <479A03DD.5030308@zytor.com>
	<20080125195058.GE28683@hmsendeavour.rdu.redhat.com>
	<20080125201305.GG13287@redhat.com>
	<20080125205450.GG28683@hmsendeavour.rdu.redhat.com>
	<20080128170811.GA1174@hmsreliant.think-freely.org>
	<20080128193741.GB32765@redhat.com>
	<20080128200702.GB1174@hmsreliant.think-freely.org>
	<20080128202041.GD32765@redhat.com>
	<20080128205324.GC1174@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080128205324.GC1174@hmsreliant.think-freely.org>
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
To: Neil Horman <nhorman@tuxdriver.com>
Cc: Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>

On Mon, Jan 28, 2008 at 03:53:24PM -0500, Neil Horman wrote:
> On Mon, Jan 28, 2008 at 03:20:41PM -0500, Vivek Goyal wrote:
> > >  
> > >  struct x86_linux_header {
> > > @@ -206,7 +210,10 @@ struct x86_linux_header {
> > >  #else
> > >  	uint32_t kernel_alignment;		/* 0x230 */
> > >  	uint8_t  relocatable_kernel;		/* 0x234 */
> > > -	uint8_t  tail[32*1024 - 0x235];		/* 0x230 */
> > > +	uint32_t cmdline_size;                  /* 0x235 */
> > > +	uint32_t hardware_subarch;              /* 0x239 */
> > > +	uint64_t hardware_subarch_data;         /* 0x23D */
> > 
> > We need a padding of 3 bytes here too between relocatable kernel and
> > cmdline_size, in the same way as x86_linux_param_header?
> > 
> 
> Oh, good catch, yes we do need that.  I expect it passed my testing because the
> garbage that wound up in cmdline_size was big enough to pass the check in
> do_bzImage_load.
> 
> New patch, same summary as before, with the above correction
> 
> Regards
> Neil
> 
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> 
> 

Thanks. Looks good to me.

Regards
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
