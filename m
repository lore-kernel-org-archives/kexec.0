Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v9 05/18] arm64: trans_pgd: pass NULL instead of init_mm
 to *_populate functions
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-6-pasha.tatashin@soleen.com>
From: James Morse <james.morse@arm.com>
Message-ID: <d19f4bc5-ad5b-5dad-0d50-271817b6c9aa@arm.com>
Date: Wed, 29 Apr 2020 18:01:11 +0100
MIME-Version: 1.0
In-Reply-To: <20200326032420.27220-6-pasha.tatashin@soleen.com>
Content-Language: en-GB
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: sashal@kernel.org, mark.rutland@arm.com, vladimir.murzin@arm.com, corbet@lwn.net, catalin.marinas@arm.com, bhsharma@redhat.com, steve.capper@arm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, linux-mm@kvack.org, rfontana@redhat.com, ebiederm@xmission.com, maz@kernel.org, matthias.bgg@gmail.com, tglx@linutronix.de, will@kernel.org, selindag@gmail.com, linux-arm-kernel@lists.infradead.org

Hi Pavel,

On 26/03/2020 03:24, Pavel Tatashin wrote:
> trans_pgd_* should be independent from mm context because the tables that
> are created by this code are used when there are no mm context around, as
> it is between kernels. Simply replace mm_init's with NULL.

arm64's p?d_populate() helpers don't use the mm parameter, so it doesn't make any
difference. This was originally done so that if we ever needed anything from the mm, we
didn't get a NULL dereference or EL0 behaviour due to a future '!= &init_mm'.

If you think it matters,
Acked-by: James Morse <james.morse@arm.com>


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
