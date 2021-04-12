Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVl9X-005Pf7-V8
 for kexec@lists.infradead.org; Mon, 12 Apr 2021 01:14:14 +0000
Date: Mon, 12 Apr 2021 09:13:47 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] x86/efi: Do not release sub-1MB memory regions when the
 crashkernel option is specified
Message-ID: <20210412011347.GA4282@MiWiFi-R3L-srv>
References: <20210407140316.30210-1-lijiang@redhat.com>
 <D7D32C89-4F99-434A-B7AF-7BEBDA494172@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D7D32C89-4F99-434A-B7AF-7BEBDA494172@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Lianbo Jiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, x86@kernel.org, ardb@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dvhart@infradead.org, andy@infradead.org, kexec@lists.infradead.org, dyoung@redhat.com

On 04/09/21 at 07:59pm, H. Peter Anvin wrote:
> Why don't we do this unconditionally? At the very best we gain half a megabyte of memory (except the trampoline, which has to live there, but it is only a few kilobytes.)

This is a great suggestion, thanks. I think we can fix it in this way to
make code simpler. Then the specific caring of real mode in
efi_free_boot_services() can be removed too.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
