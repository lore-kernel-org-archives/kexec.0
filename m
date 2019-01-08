Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggn7E-0006BQ-Hs
 for kexec@lists.infradead.org; Tue, 08 Jan 2019 08:52:05 +0000
Date: Tue, 8 Jan 2019 16:51:57 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH V2] x86/kexec: fix a kexec_file_load failure
Message-ID: <20190108085157.GB17983@MiWiFi-R3L-srv>
References: <20181228011247.GA9999@dhcp-128-65.nay.redhat.com>
 <20190108052440.GA17983@MiWiFi-R3L-srv>
 <20190108084657.GA32321@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190108084657.GA32321@dhcp-128-65.nay.redhat.com>
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
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>

On 01/08/19 at 04:46pm, Dave Young wrote:
> > Wondering why this place doesn't need the initialization assignment.
> > Isn't it to assign in all places before kexec_add_buffer() calling?
> 
> C designated initializers will make sure to initialize it as zero.
> We set KEXEC_BUF_MEM_UNKNOWN as 0 so it just works.

Got it, it works, thanks. People may need check code to find out
KEXEC_BUF_MEM_UNKNOWN is 0, then realize this fact.

Other than this, it looks good to me, ack it.

Acked-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
