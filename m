Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZSfpT-0000KJ-Lw
 for kexec@lists.infradead.org; Fri, 21 Aug 2015 06:29:31 +0000
Date: Fri, 21 Aug 2015 14:28:58 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: Dmesg not being dumped
Message-ID: <20150821062858.GA9741@dhcp-129-224.nay.redhat.com>
References: <55D42056.5070709@kyup.com>
 <20150819090202.GF19950@dhcp-128-28.nay.redhat.com>
 <55D4641D.70902@kyup.com>
 <20150821044912.GC26132@dhcppc13.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150821044912.GC26132@dhcppc13.redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: kexec@lists.infradead.org, Nikolay Borisov <kernel@kyup.com>, Baoquan He <bhe@redhat.com>

On 08/21/15 at 10:19am, Pratyush Anand wrote:
> Hi Nikolay,
> 
> On 19/08/2015:02:10:21 PM, Nikolay Borisov wrote:
> > Hi,
> > 
> > On 08/19/2015 12:02 PM, Baoquan He wrote:
> > > On 08/19/15 at 09:21am, Nikolay Borisov wrote:
> > >> Hello,
> > >>
> > >> I've recently noticed that when creating crashdumps the dmesg is not
> > >> being saved. The error reported is this: "Missing the struct log size
> > >> export". I've tested with both kernel 4.1.1 and 3.12.28. My version of
> > >> kexec tools is : kexec-tools 2.0.9 released 04 June 2015. The kernel has
> 
> Are you sure if you have 2.0.9. I see 2.0.9 is dated 09 Feb 2015.


I  believe the release date is not the real "release date" if one use
kexec --version

Because for kexec --version the date is created while building, it is
actually the build date instead of release date.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
