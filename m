Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2401:3900:2:1::2])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bX4ld-0006AW-P7
 for kexec@lists.infradead.org; Tue, 09 Aug 2016 11:00:20 +0000
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/7] ima: on soft reboot, restore the measurement list
In-Reply-To: <1470313475-20090-2-git-send-email-zohar@linux.vnet.ibm.com>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1470313475-20090-2-git-send-email-zohar@linux.vnet.ibm.com>
Date: Tue, 09 Aug 2016 20:59:51 +1000
Message-ID: <87wpjqtdg8.fsf@concordia.ellerman.id.au>
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-security-module@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ima-devel@lists.sourceforge.net, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index b5728da..84e8d36 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -102,6 +102,13 @@ struct ima_queue_entry {
>  };
>  extern struct list_head ima_measurements;	/* list of all measurements */
>  
> +/* Some details preceding the binary serialized measurement list */
> +struct ima_kexec_hdr {
> +	unsigned short version;
> +	unsigned long buffer_size;
> +	unsigned long count;
> +} __packed;
> +

Am I understanding it correctly that this structure is passed between kernels?

If so it's an ABI and should use types with well defined sizes, as if it was
going out to userspace, shouldn't it?

cheers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
