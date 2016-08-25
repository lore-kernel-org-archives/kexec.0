Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tex.lwn.net ([70.33.254.29] helo=vena.lwn.net)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bd03d-0007iM-R4
 for kexec@lists.infradead.org; Thu, 25 Aug 2016 19:11:22 +0000
Date: Thu, 25 Aug 2016 13:10:56 -0600
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v9 1/2] Documentation: kdump: remind user of nr_cpus
Message-ID: <20160825131056.58bb1379@lwn.net>
In-Reply-To: <20160824050645.GA8279@x1.redhat.com>
References: <1471489907-27737-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <1471489907-27737-2-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <20160818111854.362bb972@lwn.net> <57B653D1.8060106@cn.fujitsu.com>
 <20160819095740.1cccc073@lwn.net> <57BA51E0.1070902@cn.fujitsu.com>
 <20160824050645.GA8279@x1.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: linux-doc@vger.kernel.org, xlpang@redhat.com, "Zhou,
 =?UTF-8?B?V2Vuamlhbi/lkajmlofliZE=?=" <zhouwj-fnst@cn.fujitsu.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, joe@perches.com, akpm@linux-foundation.org, dyoung@redhat.com, vgoyal@redhat.com

On Wed, 24 Aug 2016 13:06:45 +0800
Baoquan He <bhe@redhat.com> wrote:

> Hi Jon, do you think change as below is OK to you?

So nr_cpus is the maximum value, and maxcpus is the current number.
Figures.  No wonder the documentation is confusing...

Anyway, this is much more along the lines of what I was hoping for, yes;
I'll go ahead and apply it.  Many thanks for humoring me on this!

jon

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
