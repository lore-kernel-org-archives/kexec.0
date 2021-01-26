Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 26 Jan 2021 22:58:48 +0000
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v10 00/18] arm64: MMU enabled kexec relocation
Message-ID: <20210126225847.GC30941@willie-the-truck>
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
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
Cc: sashal@kernel.org, mark.rutland@arm.com, vladimir.murzin@arm.com, corbet@lwn.net, catalin.marinas@arm.com, selindag@gmail.com, steve.capper@arm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, linux-mm@kvack.org, tyhicks@linux.microsoft.com, james.morse@arm.com, ebiederm@xmission.com, maz@kernel.org, matthias.bgg@gmail.com, rfontana@redhat.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org

Hi Pavel,

On Mon, Jan 25, 2021 at 02:19:05PM -0500, Pavel Tatashin wrote:
> Changelog:
> v10:
> 	- Addressed a lot of comments form James Morse and from  Marc Zyngier
> 	- Added review-by's
> 	- Synchronized with mainline

This series has been doing the rounds for a while, but still isn't fully
reviewed. Would it help if I merged, e.g. the first 12 patches to reduce the
amount you have to repost?

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
