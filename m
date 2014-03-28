Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WTYxn-0002EU-UL
 for kexec@lists.infradead.org; Fri, 28 Mar 2014 15:45:00 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH v4 2/4] x86: Store memory ranges globally used for crash
 kernel to boot into
Date: Fri, 28 Mar 2014 16:44:33 +0100
Message-ID: <1442762.HKg1LDRF5G@skinner>
In-Reply-To: <20140328052349.GD2944@dhcp-17-89.nay.redhat.com>
References: <1395216241-13983-1-git-send-email-chaowang@redhat.com>
 <20140327223233.GQ13816@redhat.com>
 <20140328052349.GD2944@dhcp-17-89.nay.redhat.com>
MIME-Version: 1.0
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
Cc: kexec@lists.infradead.org, horms@verge.net.au, linn@hp.com, hpa@zytor.com, dyoung@redhat.com, Vivek Goyal <vgoyal@redhat.com>, ebiederm@xmission.com

On Friday, March 28, 2014 01:23:49 PM WANG Chao wrote:
> On 03/27/14 at 06:32pm, Vivek Goyal wrote:
...

> I was just trying to keep the change as minimal as possible, so that the
> reviewers can be more clear of what the patch does instead of something
> looks messed up.
Sounds very sane. I tried it the other way around:
clean up and then do the functional change
and I ended up in a mess changing back and forth and I had to move on
to other stuff in the end.

> But if you have no problem review it, I can do some
> clean up within this patch. However I think it's better to be addressed
> the cleanup in the future, or at least as a separated patch in this
> series.
Seeing some cleanups, especially getting rid of the duplicate code to get 
memory ranges in kdump and kexec case (which I expect still exists?) on top 
later would be great.

     Thomas


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
