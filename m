Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x243.google.com ([2607:f8b0:400e:c03::243])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bZCMi-0006es-Qh
 for kexec@lists.infradead.org; Mon, 15 Aug 2016 07:31:21 +0000
Received: by mail-pa0-x243.google.com with SMTP id ez1so3198686pab.3
 for <kexec@lists.infradead.org>; Mon, 15 Aug 2016 00:31:00 -0700 (PDT)
Date: Mon, 15 Aug 2016 17:30:49 +1000
From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v5 02/13] kexec_file: Change kexec_add_buffer to take
 kexec_buf as argument.
Message-ID: <20160815073049.GB21080@balbir.ozlabs.ibm.com>
References: <1470956898-5991-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1470956898-5991-3-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1470956898-5991-3-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: bsingharora@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Aug 11, 2016 at 08:08:07PM -0300, Thiago Jung Bauermann wrote:
> Adapt all callers to the new function prototype.
>

Could you please expand on this?
 
> In addition, change the type of kexec_buf.buffer from char * to void *.
> There is no particular reason for it to be a char *, and the change
> allows us to get rid of 3 existing casts to char * in the code.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Acked-by: Dave Young <dyoung@redhat.com>
> ---

Looks good otherwise

Acked-by: Balbir Singh <bsingharora@gmail.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
