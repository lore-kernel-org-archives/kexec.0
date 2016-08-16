Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bZjRI-0005XR-8d
 for kexec@lists.infradead.org; Tue, 16 Aug 2016 18:50:17 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7GIn5BG071547
 for <kexec@lists.infradead.org>; Tue, 16 Aug 2016 14:49:54 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24tgu40eeg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 16 Aug 2016 14:49:54 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 16 Aug 2016 15:49:52 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 28705352006C
 for <kexec@lists.infradead.org>; Tue, 16 Aug 2016 14:49:28 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7GInmui12648848
 for <kexec@lists.infradead.org>; Tue, 16 Aug 2016 15:49:48 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7GInlwQ003201
 for <kexec@lists.infradead.org>; Tue, 16 Aug 2016 15:49:48 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 02/13] kexec_file: Change kexec_add_buffer to take
 kexec_buf as argument.
Date: Tue, 16 Aug 2016 15:49:46 -0300
In-Reply-To: <fab1a3ec-5252-3ca7-6382-15b84a19ccdb@gmail.com>
References: <1470956898-5991-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1906561.y8blzB2uZ8@hactar> <fab1a3ec-5252-3ca7-6382-15b84a19ccdb@gmail.com>
MIME-Version: 1.0
Message-Id: <2089791.XEmIvA1k4K@hactar>
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
To: Balbir Singh <bsingharora@gmail.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

Am Dienstag, 16 August 2016, 16:15:55 schrieb Balbir Singh:
> On 16/08/16 00:49, Thiago Jung Bauermann wrote:
> > Am Montag, 15 August 2016, 17:30:49 schrieb Balbir Singh:
> >> On Thu, Aug 11, 2016 at 08:08:07PM -0300, Thiago Jung Bauermann wrote:
> >>> Adapt all callers to the new function prototype.
> >> 
> >> Could you please expand on this?
> > 
> > Is the following better?
> > 
> > Adapt all callers to set up a kexec_buf to pass to kexec_add_buffer.
> 
> Yes and the reason for doing so? Consolidation/clarity of implementation?

Indeed. What about this commit message?

Subject: [PATCH v5 02/13] kexec_file: Change kexec_add_buffer to take  
 kexec_buf as argument.

This is done to simplify the kexec_add_buffer argument list.
Adapt all callers to set up a kexec_buf to pass to kexec_add_buffer.

In addition, change the type of kexec_buf.buffer from char * to void *.
There is no particular reason for it to be a char *, and the change
allows us to get rid of 3 existing casts to char * in the code.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Acked-by: Dave Young <dyoung@redhat.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
