Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VF7FT-0005AN-Ln
 for kexec@lists.infradead.org; Thu, 29 Aug 2013 18:47:16 +0000
Date: Thu, 29 Aug 2013 13:46:52 -0500
From: Cliff Wickman <cpw@sgi.com>
Subject: Re: [PATCH] makedumpfile: reverse -c and -p if using snappy
 compression
Message-ID: <20130829184652.GA17137@sgi.com>
References: <E1VEnuJ-0000Js-Gl@eag09.americas.sgi.com>
 <20130829025837.GA2298@dhcp12-158.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130829025837.GA2298@dhcp12-158.nay.redhat.com>
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
To: WANG Chao <chaowang@redhat.com>
Cc: kexec@lists.infradead.org, d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp

On Thu, Aug 29, 2013 at 10:58:37AM +0800, WANG Chao wrote:
> Hi, Cliff
> 
> On 08/28/13 at 05:08pm, Cliff Wickman wrote:
> > From: Cliff Wickman <cpw@sgi.com>
> > 
> > Reverse the meanings of -c (compression) and -p (snappy compression) if
> > USESNAPPY is defined.
> > 
> > The distro kdump scripts seem to only support -c for compression.
> > So make -c mean snappy compression if it is supported.
> 
> It looks like more a distro issue to me. I'm wondering if that script
> only support -c, why do that distro compile makedumpfile with USESNAPPY?
> 
> I don't think other distros would like to see this change. IMHO, the
> right thing to do is fix that kdump script on that particular distro,
> not reverse -c and -p.
> 
> Thanks
> WANG Chao

I agree that some distros could easily change their default compression
choice, for example -c to -p in RHEL's /etc/kdump.conf.

But on the other hand SLES11 just uses KDUMP_DUMPFORMAT="compressed"
in /etc/sysconfig/kdump.  Translation to -c occurs somewhere under the
covers.
Makedumpfile could change the default meaning of "compressed" to snappy
compression on the grounds that we know snappy to be much faster than
zlib compression.  And so we default to it if available.
You would in that way make the intelligent choice without administrative
intervention.
(You would also have to assume that crash is also be built snappy-capable
for a system that supports snappy compression.)

I could see it either way.
I find this patch a convenient way to make the choice.

-Cliff
-- 
Cliff Wickman
SGI
cpw@sgi.com
(651) 683-3824

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
