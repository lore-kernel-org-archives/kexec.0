Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from namei.org ([65.99.196.166])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWmnY-0001WF-7D
 for kexec@lists.infradead.org; Tue, 11 Dec 2018 18:30:25 +0000
Date: Wed, 12 Dec 2018 05:30:08 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH v2 2/7] integrity: Load certs to the platform keyring
In-Reply-To: <20181208202705.18673-3-nayna@linux.ibm.com>
Message-ID: <alpine.LRH.2.21.1812120529560.11653@namei.org>
References: <20181208202705.18673-1-nayna@linux.ibm.com>
 <20181208202705.18673-3-nayna@linux.ibm.com>
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
To: Nayna Jain <nayna@linux.ibm.com>
Cc: linux-efi@vger.kernel.org, mpe@ellerman.id.au, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, zohar@linux.ibm.com, dhowells@redhat.com, seth.forshee@canonical.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, ebiederm@xmission.com, jforbes@redhat.com, linux-integrity@vger.kernel.org, vgoyal@redhat.com

On Sun, 9 Dec 2018, Nayna Jain wrote:

> The patch refactors integrity_load_x509(), making it a wrapper for a new
> function named integrity_add_key(). This patch also defines a new
> function named integrity_load_cert() for loading the platform keys.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>


Reviewed-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
