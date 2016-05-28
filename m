Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b6eiX-0001pi-Va
 for kexec@lists.infradead.org; Sat, 28 May 2016 13:55:54 +0000
Date: Sat, 28 May 2016 14:53:20 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH kexec-tools 07/32] kexec: fix warnings caused by
 selecting 64-bit file IO on 32-bit platforms
Message-ID: <20160528135320.GQ19428@n2100.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXSV-0004hZ-CH@e0050434b2927.dyn.arm.linux.org.uk>
 <20160528113354.GB2429@x1.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160528113354.GB2429@x1.redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: Pratyush Anand <panand@redhat.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Sat, May 28, 2016 at 07:33:54PM +0800, Baoquan He wrote:
> On 05/03/16 at 11:21am, Russell King wrote:
> > diff --git a/kexec/kexec-uImage.c b/kexec/kexec-uImage.c
> > index 9df601b..5e24629 100644
> > --- a/kexec/kexec-uImage.c
> > +++ b/kexec/kexec-uImage.c
> > @@ -82,7 +82,8 @@ int uImage_probe(const unsigned char *buf, off_t len, unsigned int arch)
> >  	if (be32_to_cpu(header.ih_size) > len - sizeof(header)) {
> >  		printf("uImage header claims that image has %d bytes\n",
> >  				be32_to_cpu(header.ih_size));
> > -		printf("we read only %ld bytes.\n", len - sizeof(header));
> > +		printf("we read only %lld bytes.\n",
> > +		       (long long)len - sizeof(header));
> 
> With "D_FILE_OFFSET_BITS=64" adding, off_t is identical to off64_t, is
> that necessary to still take a type conversion here?

The printf format specifies an argument of "long long" type, which is
defined as a data type of at least 64-bits wide.  So, it's more
correct to cast to long long, rather than relying on off64_t being
the same size as long long.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
