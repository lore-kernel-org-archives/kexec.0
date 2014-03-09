Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WMXqj-0005Fk-Vd
 for kexec@lists.infradead.org; Sun, 09 Mar 2014 07:08:42 +0000
Received: by mail-ee0-f42.google.com with SMTP id d17so2478625eek.15
 for <kexec@lists.infradead.org>; Sat, 08 Mar 2014 23:08:17 -0800 (PST)
Date: Sun, 9 Mar 2014 09:08:11 +0200
From: Muli Ben-Yehuda <muli@cs.technion.ac.il>
Subject: Re: [PATCH] x86, calgary: use 8M TCE table size by default
Message-ID: <20140309070811.GB2525@needle>
References: <1394179816-15435-1-git-send-email-chaowang@redhat.com>
 <20140307141413.GF1326@redhat.com>
 <20140307155204.GC30641@dhcp-17-89.nay.redhat.com>
 <20140307160906.GH1326@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140307160906.GH1326@redhat.com>
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
Cc: Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, "Jon D. Mason" <jdmason@kudzu.us>, WANG Chao <chaowang@redhat.com>

On Fri, Mar 07, 2014 at 11:09:06AM -0500, Vivek Goyal wrote:

> I would say it is not very complicated to maintain backward
> compatibility in this case. So let us keep saved_max_pfn for some
> time and make kexec-tools changes. Some time down the line, one can
> get rid of saved_max_pfn completely.

If this is not too painful then this would be my preference too.

Cheers,
Muli

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
