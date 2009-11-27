Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mxo43.mail.genotec.ch ([2001:1b50::82:195:224:43])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NE1Zm-0007iZ-Vb
	for kexec@lists.infradead.org; Fri, 27 Nov 2009 14:13:35 +0000
Date: Fri, 27 Nov 2009 15:03:57 +0100
From: Marc Andre Tanner <mat@brain-dump.org>
Subject: Re: Architecture detection code
Message-ID: <20091127140357.GB8722@debbook.brain-dump.org>
References: <1258738692-4990-1-git-send-email-mat@brain-dump.org>
	<aec7e5c30911242113y7706e9c0u2262cdd7ab8bf38d@mail.gmail.com>
	<20091125225250.GK4794@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20091125225250.GK4794@verge.net.au>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Andrea Adami <andrea.adami@gmail.com>, kexec@lists.infradead.org, Magnus Damm <magnus.damm@gmail.com>

On Thu, Nov 26, 2009 at 09:52:52AM +1100, Simon Horman wrote:
> On Wed, Nov 25, 2009 at 02:13:56PM +0900, Magnus Damm wrote:
> > On Sat, Nov 21, 2009 at 2:38 AM, Marc Andre Tanner <mat@brain-dump.org> wrote:
> > > I recently had the same problem as Magnus and came up with the
> > > following patch. It changes the architecture detection code to
> > > also accept partiall matches. Which means and "arm" entry in
> > > arch_map_entry will work for all arm* versions.
> > >
> > > Please consider applying this patch and reverting the two from
> > > Magnus.
> > 
> > Sure, I'm happy to see that the arm supports gets more attention! =)
> 
> Hi,
> 
> I'd like to apply the following patch. Let me know if I've botched things.

Looks good.

Thanks,
Marc

-- 
 Marc Andre Tanner >< http://www.brain-dump.org/ >< GPG key: CF7D56C0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
