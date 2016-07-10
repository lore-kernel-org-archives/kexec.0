Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([103.22.144.67])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bM7yb-000737-TL
 for kexec@lists.infradead.org; Sun, 10 Jul 2016 06:12:26 +0000
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 3/9] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.
In-Reply-To: <1467908615-18952-4-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1467908615-18952-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1467908615-18952-4-git-send-email-bauerman@linux.vnet.ibm.com>
Date: Sun, 10 Jul 2016 16:11:54 +1000
Message-ID: <87a8hqja39.fsf@@concordia.ellerman.id.au>
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, Dave Young <dyoung@redhat.com>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>

Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> kexec_locate_mem_hole will be used by the PowerPC kexec_file_load
> implementation to find free memory for the purgatory stack.
>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Dave Young <dyoung@redhat.com>

Dave are you happy with the first three patches? If so do you mind
sending an ack?

Given the series touches generic code, x86 and powerpc this might be one
for Andrew to take. Or is there a kexec tree it should go through?

cheers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
