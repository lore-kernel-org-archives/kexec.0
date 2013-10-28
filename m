Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VakJf-0001Ph-Um
 for kexec@lists.infradead.org; Mon, 28 Oct 2013 10:45:00 +0000
Message-ID: <526E3F43.8050408@zytor.com>
Date: Mon, 28 Oct 2013 03:41:07 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [patch 4/4] Passing efi related data via setup_data
References: <20131027040437.600278368@dhcp-16-126.nay.redhat.com>
 <20131027041231.350640917@dhcp-16-126.nay.redhat.com>
In-Reply-To: <20131027041231.350640917@dhcp-16-126.nay.redhat.com>
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
To: dyoung@redhat.com, kexec@lists.infradead.org
Cc: mjg59@srcf.ucam.org, vgoyal@redhat.com, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, kexec@lists.fedoraproject.org

On 10/26/2013 09:04 PM, dyoung@redhat.com wrote:

> +        __uint64_t next;

WTF is __uint64_t?

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
