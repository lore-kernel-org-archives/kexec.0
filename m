Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.136] helo=mail.zytor.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fx1IO-0003hk-NS
 for kexec@lists.infradead.org; Tue, 04 Sep 2018 02:42:26 +0000
Subject: Re: [PATCH 1/3] x86/boot: Add bit fields into xloadflags for 5-level
 kernel checking
References: <20180829141624.13985-1-bhe@redhat.com>
 <20180829141624.13985-2-bhe@redhat.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <6ea94875-ae07-6220-eb3e-d3f830cdac03@zytor.com>
Date: Mon, 3 Sep 2018 19:41:29 -0700
MIME-Version: 1.0
In-Reply-To: <20180829141624.13985-2-bhe@redhat.com>
Content-Language: en-US
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
To: Baoquan He <bhe@redhat.com>, tglx@linutronix.de, mingo@kernel.org, kirill.shutemov@linux.intel.com
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

I don't understand why there is any reason not to always enter the target
kernel in 4-level mode.  There certainly is no point whatsoever in having two
xloadflags: the only thing that could possibly matter is whether or not the
kernel in question *can* be entered in 5-level mode should that ever be necessary.

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
