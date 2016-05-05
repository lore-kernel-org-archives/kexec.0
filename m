Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH RFC] Watchdog: sbsa_gwdt: Enhance timeout range
References: <5728A7C3.4010001@roeck-us.net>
 <20160503143856.GE13045@dhcppc6.redhat.com> <5728BEC4.6050603@codeaurora.org>
 <20160503155141.GF13045@dhcppc6.redhat.com>
 <20160503171602.GA2518@roeck-us.net>
 <20160504141449.GG13045@dhcppc6.redhat.com> <572A0577.1070000@codeaurora.org>
 <20160504155932.GH13045@dhcppc6.redhat.com> <572A2099.4070901@codeaurora.org>
 <20160505164300.GA16914@roeck-us.net>
 <20160505182031.GB12434@dhcppc6.redhat.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <572B8F52.2000709@codeaurora.org>
Date: Thu, 5 May 2016 13:22:10 -0500
MIME-Version: 1.0
In-Reply-To: <20160505182031.GB12434@dhcppc6.redhat.com>
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
To: Pratyush Anand <panand@redhat.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, kexec@lists.infradead.org, open list <linux-kernel@vger.kernel.org>, wim@iguana.be, fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com, Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org

Pratyush Anand wrote:
> I think, in the long run we must have SBSA
> watchdog specification improvement to keep WOR as 64 bit.

I agree with this 100%.  IMHO, using a 32-bit WOR was just a bad decision.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
