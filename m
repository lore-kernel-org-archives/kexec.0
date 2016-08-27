Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bdRbP-0001V5-F8
 for kexec@lists.infradead.org; Sat, 27 Aug 2016 00:36:04 +0000
Date: Sat, 27 Aug 2016 08:35:38 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v9 1/2] Documentation: kdump: remind user of nr_cpus
Message-ID: <20160827003538.GD31627@x1.redhat.com>
References: <1471489907-27737-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <1471489907-27737-2-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <20160818111854.362bb972@lwn.net> <57B653D1.8060106@cn.fujitsu.com>
 <20160819095740.1cccc073@lwn.net> <57BA51E0.1070902@cn.fujitsu.com>
 <20160824050645.GA8279@x1.redhat.com>
 <20160825131056.58bb1379@lwn.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160825131056.58bb1379@lwn.net>
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
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, xlpang@redhat.com, =?utf-8?B?WmhvdSwgV2Vuamlhbi/lkajmlofliZE=?= <zhouwj-fnst@cn.fujitsu.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, joe@perches.com, akpm@linux-foundation.org, dyoung@redhat.com, vgoyal@redhat.com

On 08/25/16 at 01:10pm, Jonathan Corbet wrote:
> On Wed, 24 Aug 2016 13:06:45 +0800
> Baoquan He <bhe@redhat.com> wrote:
> 
> > Hi Jon, do you think change as below is OK to you?
> 
> So nr_cpus is the maximum value, and maxcpus is the current number.
> Figures.  No wonder the documentation is confusing...

Yes. Thanks for reviewing this patchset.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
