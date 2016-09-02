Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bfoRR-0004mS-2X
 for kexec@lists.infradead.org; Fri, 02 Sep 2016 13:23:34 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u82DMcnj019009
 for <kexec@lists.infradead.org>; Fri, 2 Sep 2016 09:23:12 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25770gcaj9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 02 Sep 2016 09:23:11 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 2 Sep 2016 23:23:09 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 897742CE8054
 for <kexec@lists.infradead.org>; Fri,  2 Sep 2016 23:23:06 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u82DN67A60096632
 for <kexec@lists.infradead.org>; Fri, 2 Sep 2016 23:23:06 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u82DN5uJ006362
 for <kexec@lists.infradead.org>; Fri, 2 Sep 2016 23:23:06 +1000
Subject: Re: [PATHC v2 5/9] ima: on soft reboot, save the measurement list
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Fri, 02 Sep 2016 09:22:59 -0400
In-Reply-To: <20160901015712.GA3425@dhcp-128-65.nay.redhat.com>
References: <1472596811-9596-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1472596811-9596-6-git-send-email-zohar@linux.vnet.ibm.com>
 <20160901015712.GA3425@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Message-Id: <1472822579.3669.13.camel@linux.vnet.ibm.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ima-devel@lists.sourceforge.net, linux-security-module <linux-security-module@vger.kernel.org>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org

Hi Dave,

On Thu, 2016-09-01 at 09:57 +0800, Dave Young wrote:
> On 08/30/16 at 06:40pm, Mimi Zohar wrote:

> > + * Called during kexec_file_load so that IMA can add a segment to the kexec
> > + * image for the measurement list for the next kernel.
> > + */
> > +void ima_add_kexec_buffer(struct kimage *image)
> > +{
> > +	static int registered = 0;
> > +	struct kexec_buf kbuf = { .image = image, .buf_align = PAGE_SIZE,
> > +				  .buf_min = 0, .buf_max = ULONG_MAX,
> > +				  .top_down = true, .skip_checksum = true };
> > +	int ret;
> > +
> > +	if (!kexec_can_hand_over_buffer())
> > +		return;
> > +
> > +	kexec_segment_size = ALIGN(ima_get_binary_runtime_size() + PAGE_SIZE,
> > +				   PAGE_SIZE);
> > +
> > +	if (kexec_segment_size >= (ULONG_MAX - sizeof(long))) {
> > +		pr_err("Binary measurement list too large.\n");
> > +		return;
> > +	}
> 
> Now we added a limitation that total segment size can not be larger than
> half of totalram. see kernel/kexec_core.c sanity_check_segment_list()
> 
> So can it fail early here if kexec_segment_size is over half of total
> ram?

Sure, I'll include this change in the next post.

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
