Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vag0r-0003zU-Q5
 for kexec@lists.infradead.org; Mon, 28 Oct 2013 06:09:18 +0000
Date: Mon, 28 Oct 2013 15:08:52 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [patch 1/4] Add function get_bootparam
Message-ID: <20131028060848.GA23660@verge.net.au>
References: <20131027040437.600278368@dhcp-16-126.nay.redhat.com>
 <20131027041230.864225266@dhcp-16-126.nay.redhat.com>
 <20131028003800.GG849@verge.net.au>
 <20131028011355.GC4397@dhcp-16-126.nay.redhat.com>
 <20131028023032.GB11692@dhcp-16-126.nay.redhat.com>
 <20131028042056.GB19517@verge.net.au>
 <20131028050645.GB15827@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131028050645.GB15827@dhcp-16-126.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: mjg59@srcf.ucam.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, kexec@lists.fedoraproject.org, vgoyal@redhat.com

On Mon, Oct 28, 2013 at 01:06:45PM +0800, Dave Young wrote:
> On 10/28/13 at 01:20pm, Simon Horman wrote:
> > On Mon, Oct 28, 2013 at 10:30:32AM +0800, Dave Young wrote:
> > > On 10/28/13 at 09:13am, Dave Young wrote:
> > > > > > @@ -447,7 +446,7 @@ void setup_subarch(struct x86_linux_para
> > > > > >  	if (!debugfs_mnt)
> > > > > >  		return;
> > > > > >  	snprintf(filename, PATH_MAX, "%s/%s", debugfs_mnt, "boot_params/data");
> > > > > > -	filename[PATH_MAX-1] = 0;
> > > > > > +	filename[PATH_MAX - 1] = 0;
> > > > > >  	free(debugfs_mnt);
> > > > > 
> > > > > This change appears to be unrelated to the rest of the patch.
> > > > > 
> > > > 
> > > > Will remove the change from the patch.
> > > 
> > > Relooking it, with this patch the line "filename[PATH_MAX - 1] = 0;"
> > > is in the share function get_bootparam, it's not in setup_subarch
> > > any more so I think it's ok, what do you think?
> > 
> > I'm a bit confused.
> > 
> > My reading of the hunk above is that it is a whitespace-only change.
> > If so it is not a change that I object to but also not one that
> > I feel belongs in this patch. If not I am somehow mistaken.
> 
> The diff context is cheating us, it might because of the context (+- 3 lines)
> is same with original setup_arch, but it is really moving to a new function.

Ok, in that case I have no objections.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
