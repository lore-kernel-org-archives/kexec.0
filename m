Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WLSP3-0005hX-5V
 for kexec@lists.infradead.org; Thu, 06 Mar 2014 07:07:37 +0000
Received: by mail-ea0-f173.google.com with SMTP id r15so1496974ead.4
 for <kexec@lists.infradead.org>; Wed, 05 Mar 2014 23:07:10 -0800 (PST)
Date: Thu, 6 Mar 2014 09:00:47 +0200
From: Muli Ben-Yehuda <muli@cs.technion.ac.il>
Subject: Re: How could we get rid of saved_max_pfn for calgary iommu?
Message-ID: <20140306070047.GF16859@needle.mulix.org>
References: <20140219061824.GA29703@dhcp-17-89.nay.redhat.com>
 <20140305053617.GE26240@dhcp-17-89.nay.redhat.com>
 <20140306064756.GB16859@needle.mulix.org>
 <53181AC1.2020807@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53181AC1.2020807@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: discuss@x86-64.org, Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, WANG Chao <chaowang@redhat.com>, "Jon D. Mason" <jdmason@kudzu.us>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Wed, Mar 05, 2014 at 10:50:41PM -0800, H. Peter Anvin wrote:

> OK, second question... is it time to axe Calgary?

I don't know of anyone still using it, but it's not
impossible. Calgary and CalIOC2 machines would now be ~5-8 years old.

Cheers,
Muli

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
