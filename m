Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: Need help for arm64
References: <800dfe9c-02cf-def8-0cb6-8469553d6d00@windriver.com>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <126a7455-8899-7601-191f-00d957668dbe@infradead.org>
Date: Wed, 14 Dec 2016 09:20:40 -0800
MIME-Version: 1.0
In-Reply-To: <800dfe9c-02cf-def8-0cb6-8469553d6d00@windriver.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: He Zhe <zhe.he@windriver.com>, kexec@lists.infradead.org
Cc: Yang Shi <yang.shi@windriver.com>

Hi,

On 12/14/2016 01:42 AM, He Zhe wrote:
> Hi,
>
> I notice the function below in kexec/arch/arm64/crashdump-arm64.c. It looks it always causes "kexec -p" to return:
> "Memory for crashkernel is not reserved
>
> Do we have plan to implement this?
> Do we have workaround for arm64?

kexec does not yet support kdump.  Patches for it are in
review.  Check the kexec ML.

-Geoff

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
