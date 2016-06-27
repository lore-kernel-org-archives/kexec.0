Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bHZlA-0006dU-IK
 for kexec@lists.infradead.org; Mon, 27 Jun 2016 16:51:45 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5RGnJE4145405
 for <kexec@lists.infradead.org>; Mon, 27 Jun 2016 12:51:23 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23sjvwrar8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 27 Jun 2016 12:51:23 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 27 Jun 2016 13:51:20 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id E3EC41DC006F
 for <kexec@lists.infradead.org>; Mon, 27 Jun 2016 12:51:09 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5RGpHVJ29098398
 for <kexec@lists.infradead.org>; Mon, 27 Jun 2016 13:51:17 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5RGpHrf032374
 for <kexec@lists.infradead.org>; Mon, 27 Jun 2016 13:51:17 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 3/9] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.
Date: Mon, 27 Jun 2016 13:51:16 -0300
In-Reply-To: <5428891.iJNV8CI1We@hactar>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160627161948.GA5876@dhcp-128-65.nay.redhat.com>
 <5428891.iJNV8CI1We@hactar>
MIME-Version: 1.0
Message-Id: <1915759.R1Bukpmjaj@hactar>
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

Am Montag, 27 Juni 2016, 13:37:58 schrieb Thiago Jung Bauermann:
> Should I add a separate top_down argument to kexec_locate_mem_hole to
> control if the memory walk should be from top to bottom, and then the
> bottom_up member of struct kexec_buf controls where inside each memory
> region the memory hole will be allocated?

Er, "...the bottom_up member of struct kexec_buf..." should read "...the 
top_down member of struct kexec buf...".

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
