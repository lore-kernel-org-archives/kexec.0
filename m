Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W1KXA-00064u-C2
 for kexec@lists.infradead.org; Thu, 09 Jan 2014 18:40:48 +0000
Message-ID: <1389292470.1792.109.camel@misato.fc.hp.com>
Subject: Re: kdump failed because of hotplug memory adding in kdump kernel
From: Toshi Kani <toshi.kani@hp.com>
Date: Thu, 09 Jan 2014 11:34:30 -0700
In-Reply-To: <20140109182310.GG25897@redhat.com>
References: <52CD6E33.400@redhat.com> <20140108155829.GC13649@redhat.com>
 <8500545.JVNPnKcyD1@vostro.rjw.lan>
 <1389226308.1792.39.camel@misato.fc.hp.com>
 <20140109145035.GB25897@redhat.com>
 <1389283439.1792.66.camel@misato.fc.hp.com>
 <20140109162427.GF25897@redhat.com>
 <1389288265.1792.108.camel@misato.fc.hp.com>
 <20140109182310.GG25897@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan <bhe@redhat.com>, kexec@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, tangchen@cn.fujitsu.com, linux-acpi@vger.kernel.org, zhangyanfei@cn.fujitsu.com, dyoung@redhat.com

On Thu, 2014-01-09 at 13:23 -0500, Vivek Goyal wrote:
> On Thu, Jan 09, 2014 at 10:24:25AM -0700, Toshi Kani wrote:
> 
> [..]
> > > I think creating a new command line option is simpler as compared to
> > > creating a new flag in bootparam which in turn disables memory hotplug.
> > > More users can use that option. For example, if for some reason hotplug
> > > code is crashing, one can just disable it on command line as work around
> > > and move on.
> > 
> > I do not have a strong opinion about having such option.  However, I
> > think it is more user friendly to keep the exactmap option works alone
> > on any platforms.
> 
> I think we should create internally a variable which will disable memory
> hotplug. And set that variable based on memmap=exactmap, mem=X and also
> provide a way to disable memory hotplug directly using command line
> option.
> 
> Current kexec-tools can use memmap=exactmap and be happy. I am writing
> a new kexec syscall and will not be using memmap=exactmap and would need
> to use that command line option to disable memory hotplug behavior.

Sounds good to me.

Thanks,
-Toshi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
