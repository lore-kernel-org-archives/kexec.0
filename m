Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Q4KG7-00087i-EH
	for kexec@lists.infradead.org; Mon, 28 Mar 2011 21:45:59 +0000
Date: Mon, 28 Mar 2011 14:45:57 -0700
From: Chris Leech <christopher.leech@linux.intel.com>
Subject: Re: [PATCH] kexec, x86: fix kexec when
	boot_params.hardware_subarch != 0
Message-ID: <20110328214557.GA5670@cleech-lnx.jf.intel.com>
References: <20110328194049.32626.74038.stgit@localhost6.localdomain6>
	<20110328214012.GH4716@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110328214012.GH4716@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

On Tue, Mar 29, 2011 at 06:40:12AM +0900, Simon Horman wrote:
> > +void setup_subarch(struct x86_linux_param_header *real_mode)
> > +{
> > +	int data_file;
> > +	const off_t offset = offsetof(typeof(*real_mode), hardware_subarch);
> > +
> > +	data_file = open(BOOT_PARAMS_DBGFS, O_RDONLY);
> > +	if (data_file < 0)
> > +		return;
> > +	if (lseek(data_file, offset, SEEK_SET) < 0)
> > +		goto close;
> > +	read(data, &real_mode->hardware_subarch, sizeof(uint32_t));
> 
> Should data be data_file?

Yes.  Sorry, looks like I sent an unrefreshed patch.

- Chris

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
