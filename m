Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1469812346.16559.40.camel@infradead.org>
Subject: Re: [PATCH v1 1/4] kexec: (bugfix) calc correct end address of
 memory ranges in device tree
From: Geoff Levand <geoff@infradead.org>
Date: Fri, 29 Jul 2016 10:12:26 -0700
In-Reply-To: <20160729082714.GA1041@n2100.armlinux.org.uk>
References: <cover.1468970114.git.geoff@infradead.org>
 <3562841.ROYbCgkeeq@hactar> <20160727232331.GY1041@n2100.armlinux.org.uk>
 <1860371.lT9GInp2C3@hactar> <20160729082714.GA1041@n2100.armlinux.org.uk>
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
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Pratyush Anand <panand@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Fri, 2016-07-29 at 09:27 +0100, Russell King - ARM Linux wrote:

> So, these functions are a mess and need fixing.

Since this change isn't really related to arm64 support, I'll
drop this patch from my series.

-Geoff

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
