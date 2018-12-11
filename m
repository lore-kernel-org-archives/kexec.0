Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from namei.org ([65.99.196.166])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWn5s-0007Wg-2U
 for kexec@lists.infradead.org; Tue, 11 Dec 2018 18:49:21 +0000
Date: Wed, 12 Dec 2018 05:49:00 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH v2 6/7] efi: Allow the "db" UEFI variable to be suppressed
In-Reply-To: <20181208202705.18673-7-nayna@linux.ibm.com>
Message-ID: <alpine.LRH.2.21.1812120548480.11653@namei.org>
References: <20181208202705.18673-1-nayna@linux.ibm.com>
 <20181208202705.18673-7-nayna@linux.ibm.com>
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
Cc: linux-efi@vger.kernel.org, mpe@ellerman.id.au, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, zohar@linux.ibm.com, dhowells@redhat.com, seth.forshee@canonical.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, ebiederm@xmission.com, jforbes@redhat.com, linux-integrity@vger.kernel.org, Josh Boyer <jwboyer@fedoraproject.org>, vgoyal@redhat.com

On Sun, 9 Dec 2018, Nayna Jain wrote:

> From: Josh Boyer <jwboyer@fedoraproject.org>
> 
> If a user tells shim to not use the certs/hashes in the UEFI db variable
> for verification purposes, shim will set a UEFI variable called
> MokIgnoreDB. Have the uefi import code look for this and ignore the db
> variable if it is found.
> 
> Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Acked-by: Nayna Jain <nayna@linux.ibm.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>


Reviewed-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
