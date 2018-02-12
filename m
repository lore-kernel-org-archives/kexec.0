Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1elBoR-0001RK-2x
 for kexec@lists.infradead.org; Mon, 12 Feb 2018 10:58:20 +0000
Received: by mail-wr0-f195.google.com with SMTP id s5so14733107wra.0
 for <kexec@lists.infradead.org>; Mon, 12 Feb 2018 02:58:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180212100754.55121-15-prudo@linux.vnet.ibm.com>
References: <20180212100754.55121-1-prudo@linux.vnet.ibm.com>
 <20180212100754.55121-15-prudo@linux.vnet.ibm.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Mon, 12 Feb 2018 11:56:25 +0100
Message-ID: <CAOFm3uFfXZZuQ6cM=pi34ybxM37BQVz08ctJmh5LryVGVgEjjA@mail.gmail.com>
Subject: Re: [PATCH 14/17] s390/kexec_file: Add kexec_file_load system call
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
To: Philipp Rudo <prudo@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On Mon, Feb 12, 2018 at 11:07 AM, Philipp Rudo <prudo@linux.vnet.ibm.com> wrote:
> This patch adds the kexec_file_load system call to s390 as well as the arch
> specific functions common code requires to work. Loaders for the different
> file types will be added later.
>
> Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>

<snip>

> --- /dev/null
> +++ b/arch/s390/kernel/machine_kexec_file.c
> @@ -0,0 +1,174 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

I know this may sound weird but in .c files this should be instead:

// SPDX-License-Identifier: GPL-2.0

See Documentation/process/license-rules.rst for why.
-- 
Cordially
Philippe Ombredanne

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
