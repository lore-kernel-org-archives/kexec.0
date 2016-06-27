Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bHZYJ-0000c5-K4
 for kexec@lists.infradead.org; Mon, 27 Jun 2016 16:38:28 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5RGTrVA063260
 for <kexec@lists.infradead.org>; Mon, 27 Jun 2016 12:38:05 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23skjyq2h2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 27 Jun 2016 12:38:05 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 27 Jun 2016 13:38:03 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 56F571DC0054
 for <kexec@lists.infradead.org>; Mon, 27 Jun 2016 12:37:53 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5RGc0gJ17105378
 for <kexec@lists.infradead.org>; Mon, 27 Jun 2016 13:38:00 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5RGc0C3000997
 for <kexec@lists.infradead.org>; Mon, 27 Jun 2016 13:38:00 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 3/9] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.
Date: Mon, 27 Jun 2016 13:37:58 -0300
In-Reply-To: <20160627161948.GA5876@dhcp-128-65.nay.redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <4923900.bfxGnX6mM2@hactar>
 <20160627161948.GA5876@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Message-Id: <5428891.iJNV8CI1We@hactar>
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
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>

Am Dienstag, 28 Juni 2016, 00:19:48 schrieb Dave Young:
> On 06/23/16 at 12:37pm, Thiago Jung Bauermann wrote:
> > Am Donnerstag, 23 Juni 2016, 01:44:07 schrieb Dave Young:
> > What is bad about the description of top_down?
> It is not clear enough to me, I personally think the original one in
> source code is better:
> /* allocate from top of memory hole */

Actually I realized there's some discrepancy in how the x86 code uses 
top_down and how I need it to work in powerpc. This may be what is confusing 
about my comment and the existing comment.

x86 always walks memory from bottom to top but if top_down is true, in each 
memory region it will allocate the memory hole in the highest address within 
that region. I don't know why it is done that way, though.

On powerpc, the memory walk itself should be from top to bottom, as well as 
the memory hole allocation within each memory region.

Should I add a separate top_down argument to kexec_locate_mem_hole to 
control if the memory walk should be from top to bottom, and then the 
bottom_up member of struct kexec_buf controls where inside each memory 
region the memory hole will be allocated?

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
