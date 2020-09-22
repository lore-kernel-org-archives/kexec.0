Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKjd2-0000Ab-GI
 for kexec@lists.infradead.org; Tue, 22 Sep 2020 14:50:49 +0000
Subject: Re: [PATCH] Only allow to set crash_kexec_post_notifiers on boot time
References: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
 <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
 <20200921201811.GB3437@char.us.oracle.com> <20200922125809.66690d54@ibm>
From: boris.ostrovsky@oracle.com
Message-ID: <7ee09899-6724-e932-f73d-d49da0fb4a9d@oracle.com>
Date: Tue, 22 Sep 2020 10:50:34 -0400
MIME-Version: 1.0
In-Reply-To: <20200922125809.66690d54@ibm>
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
To: Philipp Rudo <prudo@linux.ibm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: bhe@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Eric DeVolder <eric.devolder@oracle.com>, Dave Young <dyoung@redhat.com>


On 9/22/20 6:58 AM, Philipp Rudo wrote:
>
> AFAIK pstore requires UEFI to work. So what's the point to enable it on non-UEFI
> systems?


I don't think UEFI is required, ERST can specify its own backend. And that, in fact, can be quite useful in virtualization scenarios (especially in cases of direct boot, when there is no OVMF)


-boris


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
