Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WLGl7-00048Z-RB
 for kexec@lists.infradead.org; Wed, 05 Mar 2014 18:41:38 +0000
Date: Wed, 5 Mar 2014 13:40:10 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 08/11] kexec-bzImage: Support for loading bzImage using
 64bit entry
Message-ID: <20140305184010.GC1740@redhat.com>
References: <1390849071-21989-1-git-send-email-vgoyal@redhat.com>
 <1390849071-21989-9-git-send-email-vgoyal@redhat.com>
 <20140227213629.GP18191@pd.tnic>
 <20140228163134.GG28744@redhat.com>
 <20140305163722.GC28317@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140305163722.GC28317@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: mjg59@srcf.ucam.org, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com

On Wed, Mar 05, 2014 at 05:37:22PM +0100, Borislav Petkov wrote:

[..]
> > > > +struct bzimage64_data {
> > > > +	/*
> > > > +	 * Temporary buffer to hold bootparams buffer. This should be
> > > > +	 * freed once the bootparam segment has been loaded.
> > > > +	 */
> > > > +	void *bootparams_buf;
> > > > +};
> > > 
> > > Why a struct if it is going to have only one member?
> > 
> > Well, I had started with a generic idea of bootloader being able to store
> > some data in image and retrieve it later. Finally it turned out to be only
> > one field in current implementation.
> > 
> > But I still like it as it allows storing more data down the line. There
> > is no other place where we can store bootloader specific data. So this
> > is the mechanism I created.
> 
> Right, but people would ask so you probably should hold down this
> intention in a comment somewhere.

Ok, I will put a comment.

[..]
> > > What's 2*512? Two sectors?
> > 
> > Yep, two sectors.
> 
> Also a comment or a nicely-named define then.

Ok, will do.

[..]
> > That's how boot.txt defines it. Look at 64-bit BOOT PROTOCOL.
> > 
> > 0x0202 + byte value at offset 0x0201
> > 
> > Now one can argue that create some new defines to represent those magic
> > numbers and include that file in kexec-bzimage loader. I will see what
> > can I do.
> 
> Yeah, I was simply commenting it with the innocent onlooker hat on.
> FWIW, referring to boot.txt in a comment should be helpful enough for
> people who don't have an idea where to look, methinks.

Ok, will put a reference to boot.txt.

[..]
> > 
> > At some point of time we need to start passing EFI memory map to
> > second kernel. (All the new code you and dave young have added to
> > make kexec work on EFI systems).
> 
> Right, the efi runtime pieces are already in sysfs but you'd need to put
> them somewhere for the second kernel to find out. Maybe make it part of
> the bzImage or supply it separately...

I thought Dave passed relevant information on bootparams and some in
cmdline (I have not looked at details). Once the EFI support is in, kernel
implementaion should do the same thing as kexec-tools is doing to pass EFI
mapping information to second kernel.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
