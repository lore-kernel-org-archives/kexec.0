Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VVe48-000883-Ed
 for kexec@lists.infradead.org; Mon, 14 Oct 2013 09:03:53 +0000
Date: Mon, 14 Oct 2013 11:03:22 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH 0/2] x86, apic: Disable BSP if boot cpu is AP
Message-ID: <20131014110322.32aecd6c@hananiah.suse.cz>
In-Reply-To: <20131009202012.GO6383@redhat.com>
References: <20130829092458.5476.10277.stgit@localhost6.localdomain6>
 <521F5297.4070906@linux.intel.com>
 <521FDE8D.4040807@jp.fujitsu.com>
 <5220BDBC.2060807@linux.intel.com>
 <20131009202012.GO6383@redhat.com>
Mime-Version: 1.0
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: jingbai.ma@hp.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, akpm@linux-foundation.org, "H. Peter Anvin" <hpa@linux.intel.com>, Vivek Goyal <vgoyal@redhat.com>

On Wed, 9 Oct 2013 16:20:12 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Fri, Aug 30, 2013 at 08:43:56AM -0700, H. Peter Anvin wrote:
> > On 08/29/2013 04:51 PM, HATAYAMA Daisuke wrote:
> > > 
> > > This is not a regression just as Eric explains.
> > > 
> > > There is also my explanation in the description of the 2nd patch. I
> > > should have described so here explicitly.
> > > 
> > 
> > OK.  We're probably days away from a merge window, so I would like to
> > put this in the queue for 3.13.
> 
> Hi hpa,
> 
> Have you queued up these patches for 3.13?

Yeah, I'm also interested. But I think we were waiting for HATAYAMA
Daisuke to send a cleaned up version of the patch set.

@HATAYAMA: If you're too busy to clean up the series, I can do that for
you and re-send it here. But I don't want to "steal" the work from you.

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
