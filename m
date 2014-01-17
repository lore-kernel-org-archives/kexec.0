Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W4EvF-0002ya-HJ
 for kexec@lists.infradead.org; Fri, 17 Jan 2014 19:17:42 +0000
Date: Fri, 17 Jan 2014 14:17:14 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 4/6] kexec: A new system call, kexec_file_load, for in
 kernel kexec
Message-ID: <20140117191714.GH24394@redhat.com>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <1384969851-7251-5-git-send-email-vgoyal@redhat.com>
 <alpine.LRH.2.00.1311222136030.9932@twin.jikos.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.1311222136030.9932@twin.jikos.cz>
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
To: Jiri Kosina <jkosina@suse.cz>
Cc: mjg59@srcf.ucam.org, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com

On Fri, Nov 22, 2013 at 09:42:52PM +0100, Jiri Kosina wrote:

[..]
> > @@ -843,7 +1075,11 @@ static int kimage_load_normal_segment(struct kimage *image,
> >  				PAGE_SIZE - (maddr & ~PAGE_MASK));
> >  		uchunk = min(ubytes, mchunk);
> >  
> > -		result = copy_from_user(ptr, buf, uchunk);
> > +		/* For file based kexec, source pages are in kernel memory */
> > +		if (image->file_mode)
> > +			memcpy(ptr, buf, uchunk);
> 
> Very minor nit I came across when going through the patchset -- can't we 
> use some different buffer for the file-based kexec that's not marked 
> __user here? This really causes some eye-pain when looking at the code.

Hi Jiri,

Sorry, responding to your comment after a very long time.

Now I have made buf field a union as it can either be a user pointer or
a kernel pointer depending on which kexec syscall has been used. Now
caller needs to either use segment->buf or segment->kbuf based on the
context of code.

	kexec_segment {
		union {
			void __user *buf;
			void *kbuf;
		};
	}

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
