Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eePSV-0008Bi-8k
 for kexec@lists.infradead.org; Wed, 24 Jan 2018 18:07:40 +0000
Subject: Re: [PATCH v2 2/2] kexec-tools: Make xc_dlhandle static
References: <1516734771-14795-1-git-send-email-eric.devolder@oracle.com>
 <1516734771-14795-3-git-send-email-eric.devolder@oracle.com>
 <20180123205914.GQ4675@olila.local.net-space.pl>
 <20180124083611.2iqfgqke4plmw4i3@verge.net.au>
From: Eric DeVolder <eric.devolder@oracle.com>
Message-ID: <05f37ef7-2a8b-ad65-58a7-61ccda19b50d@oracle.com>
Date: Wed, 24 Jan 2018 12:08:02 -0600
MIME-Version: 1.0
In-Reply-To: <20180124083611.2iqfgqke4plmw4i3@verge.net.au>
Content-Language: en-US
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
To: Simon Horman <horms@verge.net.au>, Daniel Kiper <daniel.kiper@oracle.com>
Cc: andrew.cooper3@citrix.com, kexec@lists.infradead.org, konrad.wilk@oracle.com



On 01/24/2018 02:36 AM, Simon Horman wrote:
> On Tue, Jan 23, 2018 at 09:59:14PM +0100, Daniel Kiper wrote:
>> On Tue, Jan 23, 2018 at 01:12:51PM -0600, Eric DeVolder wrote:
>>> This patch is a follow-on to commit 43d3932e "kexec-tools: Perform
>>> run-time linking of libxenctrl.so". This patch addresses feedback
>>> from Daniel Kiper.
>>>
>>> This patch implements Daniel's suggestion to make the
>>> xc_dlhandle variable static.
>>>
>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>>
>> Just two nitpicks... Otherwise you can add
>>
>> Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
> 
> Eric, please address Daniel's review and repost this patch as appropriate.
> There is no need to repost patch 1/2 as I've applied it.
> 

Simon, I've incorporated Daniel's feedback and posted v3 of this patch.
Regards,
eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
