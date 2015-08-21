Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZSeGm-00022w-E9
 for kexec@lists.infradead.org; Fri, 21 Aug 2015 04:49:36 +0000
Date: Fri, 21 Aug 2015 10:19:12 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: Dmesg not being dumped
Message-ID: <20150821044912.GC26132@dhcppc13.redhat.com>
References: <55D42056.5070709@kyup.com>
 <20150819090202.GF19950@dhcp-128-28.nay.redhat.com>
 <55D4641D.70902@kyup.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55D4641D.70902@kyup.com>
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
To: Nikolay Borisov <kernel@kyup.com>
Cc: kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>

Hi Nikolay,

On 19/08/2015:02:10:21 PM, Nikolay Borisov wrote:
> Hi,
> 
> On 08/19/2015 12:02 PM, Baoquan He wrote:
> > On 08/19/15 at 09:21am, Nikolay Borisov wrote:
> >> Hello,
> >>
> >> I've recently noticed that when creating crashdumps the dmesg is not
> >> being saved. The error reported is this: "Missing the struct log size
> >> export". I've tested with both kernel 4.1.1 and 3.12.28. My version of
> >> kexec tools is : kexec-tools 2.0.9 released 04 June 2015. The kernel has

Are you sure if you have 2.0.9. I see 2.0.9 is dated 09 Feb 2015.

commit 8e762175d295aad08a1cc62d6394e8285f225a40
Author: Simon Horman <horms@verge.net.au>
Date:   Mon Feb 9 14:33:24 2015 +0900

    kexec-tools 2.0.9


> >> been compiled with debugging info so the respective symbol should be
> >> exported but apparently it is not. Any ideas how to debug that?

Can you please cross check that you have following patch in your kexec-tool. If
you have that patch, then its really strange that you see this issue.

commit c96b723e17eb4af689de494b636d8bded4b98c88
Author: Vivek Goyal <vgoyal@redhat.com>
Date:   Thu May 22 10:43:14 2014 -0400

    vmcore-dmesg: Handle struct log to struct printk_log renaming

~Pratyush    

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
