Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1ToIap-0006sK-KY
 for kexec@lists.infradead.org; Thu, 27 Dec 2012 18:54:12 +0000
Message-ID: <50DC9935.6000201@zytor.com>
Date: Thu, 27 Dec 2012 10:53:41 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 09/11] x86/xen/enlighten: Add init and crash kexec/kdump
 hooks
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-2-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-3-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-4-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-5-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-6-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-7-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-8-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-9-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-10-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1356574740-6806-10-git-send-email-daniel.kiper@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: xen-devel@lists.xensource.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, ebiederm@xmission.com, jbeulich@suse.com, maxim.uvarov@oracle.com, tglx@linutronix.de, vgoyal@redhat.com

On 12/26/2012 06:18 PM, Daniel Kiper wrote:
> Add init and crash kexec/kdump hooks.
>
> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> ---
>   arch/x86/xen/enlighten.c |   11 +++++++++++
>   1 files changed, 11 insertions(+), 0 deletions(-)

On the general issue of hooks:

Hooks need their pre- and postsemantics extremely ewell documented, let 
they end up being an impossible roadblock to development.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
