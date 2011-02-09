Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PnJPo-0007Ly-Ma
	for kexec@lists.infradead.org; Wed, 09 Feb 2011 23:25:41 +0000
Date: Thu, 10 Feb 2011 08:25:32 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] kexec-tools: Don't duplicate the bzImage header area
Message-ID: <20110209232529.GA6902@verge.net.au>
References: <20110208152036.GA6615@laptop> <20110208221545.GJ5540@verge.net.au>
	<20110209111304.GA6972@laptop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110209111304.GA6972@laptop>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On Wed, Feb 09, 2011 at 01:13:04PM +0200, Ahmed S. Darwish wrote:
> On Wed, Feb 09, 2011 at 07:15:45AM +0900, Simon Horman wrote:
> > On Tue, Feb 08, 2011 at 05:20:36PM +0200, Ahmed S. Darwish wrote:
> > > 
> > > diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
> > > index 83d3a69..2312eb8 100644
> > > --- a/kexec/arch/i386/kexec-bzImage.c
> > > +++ b/kexec/arch/i386/kexec-bzImage.c
> > > @@ -43,32 +43,32 @@ static const int probe_debug = 0;
> > >  
> > >  int bzImage_probe(const char *buf, off_t len)
> > >  {
> > > -	struct x86_linux_header header;
> > > +	const struct x86_linux_header *header;
> > >  	if ((uintmax_t)len < (uintmax_t)sizeof(header)) {
> > >  		return -1;
> > >  	}
> > > -	memcpy(&header, buf, sizeof(header));
> > > -	if (memcmp(header.header_magic, "HdrS", 4) != 0) {
> > > +	header = (void *)buf;
> > 
> > Perhaps casting to (struct x86_linux_header*) would read better?
> > 
> 
> I felt that '(const struct x86_linux_header *)' is a bit long, but it's
> not a big deal. Attached is the same patch with that line modified:
> 
> ==>
> 
> Don't wholeheartedly copy the 32-Kbytes bzImage header area to the stack,
> just use a constant pointer instead.

Thanks, applied.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
