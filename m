Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1eymj2-0008GW-Es
 for kexec@lists.infradead.org; Wed, 21 Mar 2018 23:00:57 +0000
Date: Wed, 21 Mar 2018 16:00:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 00/11] kexec_file: Clean up purgatory load
Message-Id: <20180321160042.0f7d1fe21937f37af96a982a@linux-foundation.org>
In-Reply-To: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
References: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
Mime-Version: 1.0
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
To: Philipp Rudo <prudo@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Wed, 21 Mar 2018 12:27:40 +0100 Philipp Rudo <prudo@linux.vnet.ibm.com> wrote:

> here is the updated patch set including Dave's comments.

There were some syntactic clashes with the "kexec_file, x86, powerpc:
refactoring for other architecutres" series.  Please check (in
linux-next) that I got it all correct and that both patch series are
functioning correctly.

I expect to send all this into Stephen for -next tomorrow.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
